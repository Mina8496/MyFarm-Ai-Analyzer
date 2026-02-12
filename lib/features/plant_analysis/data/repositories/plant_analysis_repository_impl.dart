import 'dart:io';
import 'package:myfarm/features/plant_analysis/data/datasources/plant_id_remote_datasource.dart';
import 'package:myfarm/features/plant_analysis/data/knowledge/DiseaseArabicEnricher.dart';
import 'package:myfarm/features/plant_analysis/domain/entities/Disease_Model.dart';
import 'package:myfarm/features/plant_analysis/domain/entities/plant_analysis_entity.dart';
import 'package:myfarm/features/plant_analysis/domain/repositories/PlantAnalysisRepository.dart';

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
