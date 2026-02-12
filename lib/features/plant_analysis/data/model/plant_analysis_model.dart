import 'package:myfarm/features/plant_analysis/domain/entities/Disease_Model.dart';
import 'package:myfarm/features/plant_analysis/domain/entities/plant_analysis_entity.dart';

class PlantAnalysisModel {
  final bool isPlant;
  final bool isHealthy;
  final String plantName;
  final String? followUpQuestion;
  final double confidence;
  final double healthProbability;
  final int? followUpYesIndex;
  final List<DiseaseModel> diseases;

  PlantAnalysisModel({
    required this.isPlant,
    required this.plantName,
    required this.confidence,
    required this.diseases,
    required this.isHealthy,
    required this.healthProbability,
    this.followUpQuestion,
    this.followUpYesIndex,
  });

  factory PlantAnalysisModel.fromJson(Map<String, dynamic> json) {
    final result = json['result'];

    final Map<String, dynamic>? question =
        result['disease']?['question'] as Map<String, dynamic>?;

    final classificationSuggestions =
        result['classification']?['suggestions'] as List? ?? [];

    final plantSuggestion = classificationSuggestions.isNotEmpty
        ? classificationSuggestions.first
        : null;

    final diseaseSuggestions = result['disease']?['suggestions'] as List? ?? [];

    final diseases = diseaseSuggestions.map<DiseaseModel>((d) {
      final details = d['details'] ?? {};
      final confidence = ((d['probability'] ?? 0) as num).toDouble();

      return DiseaseModel(
        name: d['name'] ?? '',
        originalName: d['name'] ?? '',
        confidence: confidence,
        entityId: details['entity_id'],
        description: null,
        causes: const [],
        symptoms: const [],
        chemicalTreatment: const [],
        biologicalTreatment: const [],
        prevention: const [],
        severity: calculateAgricultureSeverity(
          confidence: confidence,
          diseaseName: d['name'],
        ),
      );
    }).toList();

    return PlantAnalysisModel(
      isPlant: result['is_plant']?['binary'] ?? false,
      isHealthy: result['is_healthy']?['binary'] ?? false,
      healthProbability: ((result['is_healthy']?['probability'] ?? 0) as num)
          .toDouble(),
      plantName: plantSuggestion?['name'] ?? 'Unknown',
      confidence: ((plantSuggestion?['probability'] ?? 0) as num).toDouble(),
      diseases: diseases,
      followUpQuestion:
          json['result']['disease']['question']?['translation'] ??
          json['result']['disease']['question']?['text'],
      followUpYesIndex: question?['options']?['yes']?['suggestion_index'],
    );
  }

  PlantAnalysisEntity toEntity() {
    return PlantAnalysisEntity(
      isPlant: isPlant,
      isHealthy: isHealthy,
      plantName: plantName,
      confidence: confidence,
      diseases: diseases,
      followUpQuestion: followUpQuestion,
      followUpYesIndex: followUpYesIndex,
    );
  }
}

int calculateAgricultureSeverity({
  required double confidence,
  required String diseaseName,
}) {
  final name = diseaseName.toLowerCase();

  if (name.contains('late blight')) return 5;
  if (name.contains('bacterial')) return 4;
  if (name.contains('fungal')) return 3;
  if (name.contains('virus')) return 5;
  if (name.contains('mildew')) return 3;

  if (confidence > 0.85) return 4;
  if (confidence > 0.6) return 3;
  return 2;
}
