import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:myfarm/features/plant_analysis/Presentation/Controller/TranslationController.dart';
import 'package:myfarm/features/plant_analysis/Presentation/Controller/plant_analysis_controller.dart';
import 'package:myfarm/features/plant_analysis/data/datasources/plant_id_remote_datasource.dart';
import 'package:myfarm/features/plant_analysis/data/repositories/plant_analysis_repository_impl.dart';
import 'package:myfarm/features/plant_analysis/domain/usecases/GetDiseaseDetailsUseCase.dart';
import 'package:myfarm/features/plant_analysis/domain/usecases/analyze_plant_usecase.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
 Get.put(TranslationController());
    final remoteDataSource = PlantIdRemoteDataSource();
    final repository = PlantAnalysisRepositoryImpl(remoteDataSource);

    Get.lazyPut<PlantAnalysisController>(
      () => PlantAnalysisController(
        analyzePlantUseCase: AnalyzePlantUseCase(repository),
        getDiseaseDetailsUseCase: GetDiseaseDetailsUseCase(repository),
      ),
      fenix: true,
    );
  }
}


