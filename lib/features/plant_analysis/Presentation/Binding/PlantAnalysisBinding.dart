import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:myfarm/features/plant_analysis/Presentation/Controller/plant_analysis_controller.dart';
import 'package:myfarm/features/plant_analysis/data/datasources/plant_id_remote_datasource.dart';
import 'package:myfarm/features/plant_analysis/data/repositories/plant_analysis_repository_impl.dart';
import 'package:myfarm/features/plant_analysis/domain/repositories/PlantAnalysisRepository.dart';
import 'package:myfarm/features/plant_analysis/domain/usecases/GetDiseaseDetailsUseCase.dart';
import 'package:myfarm/features/plant_analysis/domain/usecases/analyze_plant_usecase.dart';

class PlantAnalysisBinding extends Bindings {
  @override
  void dependencies() {
    // DataSource
    Get.lazyPut<PlantIdRemoteDataSource>(
      () => PlantIdRemoteDataSource(),
      fenix: true,
    );

    // Repository
    Get.lazyPut<PlantAnalysisRepository>(
      () => PlantAnalysisRepositoryImpl(Get.find<PlantIdRemoteDataSource>()),
      fenix: true,
    );

    // UseCases
    Get.lazyPut(() => AnalyzePlantUseCase(Get.find<PlantAnalysisRepository>()));

    Get.lazyPut(
      () => GetDiseaseDetailsUseCase(Get.find<PlantAnalysisRepository>()),
    );

    // Controller
    Get.lazyPut<PlantAnalysisController>(
      () => PlantAnalysisController(
        analyzePlantUseCase: Get.find(),
        getDiseaseDetailsUseCase: Get.find(),
      ),
      fenix: true,
    );
  }
}
