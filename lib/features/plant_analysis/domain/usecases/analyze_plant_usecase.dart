import 'dart:io';
import 'package:myfarm/features/plant_analysis/domain/repositories/PlantAnalysisRepository.dart';

import '../entities/plant_analysis_entity.dart';

class AnalyzePlantUseCase {
  final PlantAnalysisRepository repository;

  AnalyzePlantUseCase(this.repository);

  Future<PlantAnalysisEntity> call(File imageFile) {
    print('🟡 UseCase started');
    print('🟢 UseCase finished');
    return repository.analyzePlantImage(imageFile);
    
  }
}

