import 'dart:io';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:myfarm/features/plant_analysis/data/knowledge/DiseaseArabicEnricher.dart';
import 'package:myfarm/features/plant_analysis/data/knowledge/PlantNameArabicMapper.dart';
import 'package:myfarm/features/plant_analysis/domain/entities/Disease_Model.dart';
import 'package:myfarm/features/plant_analysis/domain/entities/PlantHistoryEntity.dart';
import 'package:myfarm/features/plant_analysis/domain/entities/plant_analysis_entity.dart';
import 'package:myfarm/features/plant_analysis/domain/usecases/GetDiseaseDetailsUseCase.dart';
import 'package:myfarm/features/plant_analysis/domain/usecases/analyze_plant_usecase.dart';

class PlantAnalysisController extends GetxController {
  final AnalyzePlantUseCase analyzePlantUseCase;
  final GetDiseaseDetailsUseCase getDiseaseDetailsUseCase;
  final FlutterTts _tts = FlutterTts();

  PlantAnalysisController({
    required this.analyzePlantUseCase,
    required this.getDiseaseDetailsUseCase,
  });

  final loading = false.obs;
  final error = ''.obs;

  final result = Rxn<PlantAnalysisEntity>();
  final selectedDisease = Rxn<DiseaseModel>();
  final followUpAnswered = false.obs;

  Rx<File?> imageFile = Rx<File?>(null);

  Future<void> analyzeImage(File image) async {
    loading.value = true;
    error.value = '';
    followUpAnswered.value = false;
    selectedDisease.value = null;
    imageFile.value = image;

    try {
      final analysis = await analyzePlantUseCase(image);

      if (!analysis.isPlant) {
        error.value = 'The image is not of a plant'.tr;
        return;
      }

      final enrichedDiseases = analysis.diseases
          .map(DiseaseArabicEnricher.enrich)
          .toList();

      final enrichedResult = PlantAnalysisEntity(
        isPlant: analysis.isPlant,
        isHealthy: analysis.isHealthy,
        plantName: PlantNameArabicMapper.translate(analysis.plantName),
        confidence: analysis.confidence,
        diseases: enrichedDiseases,
        followUpQuestion: analysis.followUpQuestion,
        followUpYesIndex: analysis.followUpYesIndex,
      );

      result.value = enrichedResult;
      saveToHistory(enrichedResult);
    } catch (e) {
      error.value = 'Image analysis is currently unavailable.'.tr;
    } finally {
      loading.value = false;
    }
  }

  Future<void> answerFollowUp(bool yes) async {
    followUpAnswered.value = true;

    final analysis = result.value;
    if (analysis == null) return;

    final index = yes ? analysis.followUpYesIndex : 1;

    if (index == null || index >= analysis.diseases.length) return;

    loading.value = true;

    try {
      // final disease = analysis.diseases[index];

      final enrichedDiseases = analysis.diseases
          .map(DiseaseArabicEnricher.enrich)
          .toList();

      result.value = PlantAnalysisEntity(
        isPlant: analysis.isPlant,
        isHealthy: analysis.isHealthy,
        plantName: PlantNameArabicMapper.translate(analysis.plantName),
        confidence: analysis.confidence,
        diseases: enrichedDiseases,
        followUpQuestion: analysis.followUpQuestion,
        followUpYesIndex: analysis.followUpYesIndex,
      );
    } catch (_) {
      error.value = 'Unable to load disease details'.tr;
    } finally {
      loading.value = false;
    }
  }

  ////////////////////////////////  speak  ////////////////////////////////////
  @override
  void onInit() {
    super.onInit();

    _tts.setLanguage("ar-EG");
    _tts.setSpeechRate(0.48);
    _tts.setPitch(1.08);
    _tts.setVolume(1.0);
  }

  Future<void> speakResult() async {
    final r = result.value;
    if (r == null) return;

    final text = StringBuffer();

    if (r.isHealthy) {
      text.writeln("النبات حالته كويسة ومفيش أمراض ظاهرة.");
    } else {
      text.writeln("للأسف، النبات فيه إصابة.");
    }

    for (final d in r.diseases) {
      text.writeln("المرض اسمه ${d.name}.");

      final percent = (d.confidence * 100).round();
      text.writeln("نسبة التأكد حوالي $percent في المية.");

      if (d.severity >= 4) {
        text.writeln("الإصابة شديدة، ويفضل تبدأ العلاج في أسرع وقت.");
      }

      if (d.chemicalTreatment.isNotEmpty) {
        text.writeln("العلاج المقترح هو:");
        for (final t in d.chemicalTreatment) {
          text.writeln(t);
        }
      }
    }

    await _tts.stop();
    await Future.delayed(const Duration(milliseconds: 250));
    await _tts.speak(text.toString());
  }

  Future<void> stopSpeaking() async {
    await _tts.stop();
  }

  /////////////////history//////////////////////////////
  final history = <PlantHistoryEntity>[].obs;

  void saveToHistory(PlantAnalysisEntity result) {
    if (result.diseases.isEmpty) return;

    final d = result.diseases.first;

    history.insert(
      0,
      PlantHistoryEntity(
        plantName: result.plantName,
        diseaseName: d.name,
        severity: d.severity,
        date: DateTime.now(),
      ),
    );
  }
}
