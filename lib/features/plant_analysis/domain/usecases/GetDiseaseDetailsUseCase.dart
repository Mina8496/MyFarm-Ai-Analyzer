import 'package:myfarm/features/plant_analysis/domain/entities/Disease_Model.dart';
import 'package:myfarm/features/plant_analysis/domain/repositories/PlantAnalysisRepository.dart';

class GetDiseaseDetailsUseCase {
  final PlantAnalysisRepository repository;

  GetDiseaseDetailsUseCase(this.repository);

  Future<DiseaseModel> call(DiseaseModel disease) {
    return repository.enrichDisease(disease);
  }
}
