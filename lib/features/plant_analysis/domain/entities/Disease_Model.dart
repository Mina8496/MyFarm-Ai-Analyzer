class DiseaseModel {
  final String name;
  final String originalName;
  final double confidence;
  final String entityId; // 👈 جديد
  final String? description;
  final List<String> causes;
  final List<String> symptoms;
  final List<String> chemicalTreatment;
  final List<String> biologicalTreatment;
  final List<String> prevention;
  final int severity;

  DiseaseModel({
    required this.name,
    required this.originalName,
    required this.confidence,
    required this.entityId,
    this.description,
    this.causes = const [],
    this.symptoms = const [],
    this.chemicalTreatment = const [],
    this.biologicalTreatment = const [],
    this.prevention = const [],
    this.severity = 0,
  });

  DiseaseModel copyWith({
    String? name,
    String? description,
    List<String>? causes,
    List<String>? symptoms,
    List<String>? chemicalTreatment,
    List<String>? biologicalTreatment,
    List<String>? prevention,
    int? severity,
  }) {
    return DiseaseModel(
      name: name ?? this.name,
      originalName: originalName,
      confidence: confidence,
      entityId: entityId,
      severity: severity ?? this.severity,
      description: description ?? this.description,
      causes: causes ?? this.causes,
      symptoms: symptoms ?? this.symptoms,
      chemicalTreatment: chemicalTreatment ?? this.chemicalTreatment,
      biologicalTreatment: biologicalTreatment ?? this.biologicalTreatment,
      prevention: prevention ?? this.prevention,
    );
  }
}
