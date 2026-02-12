  import 'Disease_Model.dart';

  class PlantAnalysisEntity {
    final bool isPlant;
    final bool isHealthy;
    final double confidence;
    final String plantName;

    final List<DiseaseModel> diseases;

    /// Follow-up
    final String? followUpQuestion;
    final int? followUpYesIndex;

    PlantAnalysisEntity({
      required this.isPlant,
      required this.isHealthy,
      required this.plantName,
      required this.confidence,
      required this.diseases,
      this.followUpQuestion,
      this.followUpYesIndex,
    });
  }
