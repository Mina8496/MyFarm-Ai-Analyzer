import 'package:myfarm/features/plant_analysis/data/knowledge/DiseaseKnowledgeHelper.dart';
import 'package:myfarm/features/plant_analysis/domain/entities/Disease_Model.dart';

class DiseaseArabicEnricher {
  static DiseaseModel enrich(DiseaseModel disease) {
    final knowledge = DiseaseKnowledgeHelper.fromPlantId(disease.name);

    if (knowledge == null) return disease;

    return disease.copyWith(
      name: knowledge['name'] ?? disease.name,
      severity: knowledge['severity'] ?? disease.severity,
      description: knowledge['description'],
      symptoms: List<String>.from(knowledge['symptoms'] ?? []),
      causes: List<String>.from(knowledge['causes'] ?? []),
      chemicalTreatment: List<String>.from(
        knowledge['chemicalTreatment'] ?? [],
      ),
      biologicalTreatment: List<String>.from(
        knowledge['biologicalTreatment'] ?? [],
      ),
      prevention: List<String>.from(knowledge['prevention'] ?? []),
    );
  }
}
