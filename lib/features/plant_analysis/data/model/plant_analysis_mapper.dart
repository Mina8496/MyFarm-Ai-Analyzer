import 'package:myfarm/features/plant_analysis/data/model/plant_analysis_model.dart';
import 'package:myfarm/features/plant_analysis/domain/entities/plant_analysis_entity.dart';

extension PlantAnalysisMapper on PlantAnalysisModel {
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
