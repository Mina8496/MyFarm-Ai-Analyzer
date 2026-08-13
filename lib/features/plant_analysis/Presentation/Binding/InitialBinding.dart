import 'package:get/get.dart';
import 'package:myfarm/core/localization/translation_controller.dart';
import 'package:myfarm/features/plant_analysis/Presentation/Controller/plant_analysis_controller.dart';
import 'package:myfarm/features/plant_analysis/data/datasources/plant_id_remote_datasource.dart';
import 'package:myfarm/features/plant_analysis/data/repositories/plant_analysis_repository_impl.dart';
import 'package:myfarm/features/plant_analysis/domain/usecases/GetDiseaseDetailsUseCase.dart';
import 'package:myfarm/features/plant_analysis/domain/usecases/analyze_plant_usecase.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TranslationController());

    Get.lazyPut<PlantIdRemoteDataSource>(
      () => PlantIdRemoteDataSource(),
      fenix: true,
    );

    Get.lazyPut<PlantAnalysisRepositoryImpl>(
      () => PlantAnalysisRepositoryImpl(Get.find<PlantIdRemoteDataSource>()),
      fenix: true,
    );

    Get.lazyPut<PlantAnalysisController>(
      () => PlantAnalysisController(
        analyzePlantUseCase: AnalyzePlantUseCase(
          Get.find<PlantAnalysisRepositoryImpl>(),
        ),
        getDiseaseDetailsUseCase: GetDiseaseDetailsUseCase(
          Get.find<PlantAnalysisRepositoryImpl>(),
        ),
      ),
      fenix: true,
    );
  }
}


