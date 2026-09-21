import 'dart:io';
import 'package:myfarm/features/plant_analysis/data/datasources/plant_id_remote_datasource.dart';
import 'package:myfarm/features/plant_analysis/data/knowledge/disease_arabic_enricher.dart';
import 'package:myfarm/features/plant_analysis/domain/entities/disease_model.dart';
import 'package:myfarm/features/plant_analysis/domain/entities/plant_analysis_entity.dart';
import 'package:myfarm/features/plant_analysis/domain/repositories/plant_analysis_repository.dart';

class PlantAnalysisRepositoryImpl implements PlantAnalysisRepository {
  final PlantIdRemoteDataSource remote;

  PlantAnalysisRepositoryImpl(this.remote);

  @override
  Future<PlantAnalysisEntity> analyzePlantImage(File imageFile) {
    return remote.analyzeImage(imageFile).then((m) => m.toEntity());
  }

  @override
  Future<DiseaseModel> enrichDisease(DiseaseModel disease) async {
    return DiseaseArabicEnricher.enrich(disease);
  }

  // @override
  // Future<DiseaseModel> enrichDisease(DiseaseModel disease) async {
  //   return remote.getDiseaseDetails(disease);
  // }
}
