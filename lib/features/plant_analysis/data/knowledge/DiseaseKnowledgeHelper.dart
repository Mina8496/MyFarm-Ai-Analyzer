import 'DiseaseKnowledge.dart';
import 'DiseaseKeyMapper.dart';

class DiseaseKnowledgeHelper {
  static Map<String, dynamic>? fromPlantId(String diseaseName) {
    final key = DiseaseKeyMapper.map(diseaseName);
    if (key == null) return null;
    return DiseaseKnowledge.get(key);
  }
}
