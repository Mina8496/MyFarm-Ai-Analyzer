import 'dart:io';
import '../entities/disease_model.dart';
import '../entities/plant_analysis_entity.dart';

abstract class PlantAnalysisRepository {
  Future<PlantAnalysisEntity> analyzePlantImage(File imageFile);

  Future<DiseaseModel> enrichDisease(DiseaseModel disease);
}
