import 'package:myfarm/features/plant_analysis/domain/entities/Disease_Model.dart';

class KnowledgeCache {
  static final KnowledgeCache _instance = KnowledgeCache._();
  KnowledgeCache._();

  factory KnowledgeCache() => _instance;

  final Map<String, DiseaseModel> _cache = {};

  DiseaseModel? get(String entityId) => _cache[entityId];

  void save(DiseaseModel disease) {
    _cache[disease.entityId] = disease;
  }
}
