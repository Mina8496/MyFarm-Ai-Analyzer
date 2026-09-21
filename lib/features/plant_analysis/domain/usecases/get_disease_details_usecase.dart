import 'package:myfarm/features/plant_analysis/domain/entities/disease_model.dart';
import 'package:myfarm/features/plant_analysis/domain/repositories/plant_analysis_repository.dart';

class GetDiseaseDetailsUseCase {
  final PlantAnalysisRepository repository;

  GetDiseaseDetailsUseCase(this.repository);

  Future<DiseaseModel> call(DiseaseModel disease) {
    return repository.enrichDisease(disease);
  }
}
