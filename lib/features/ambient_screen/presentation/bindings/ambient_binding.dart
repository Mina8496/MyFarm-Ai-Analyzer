import 'package:get/get.dart';
import 'package:myfarm/features/ambient_screen/presentation/widgets/close_ambient_screen.dart';
import 'package:myfarm/features/ambient_screen/presentation/widgets/get_ambient_settings.dart';
import '../../data/datasources/ambient_local_data_source.dart';
import '../../data/repositories/ambient_repository_impl.dart';
import '../../domain/repositories/ambient_repository.dart';
import '../controllers/ambient_controller.dart';

class AmbientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AmbientLocalDataSource>(() => AmbientLocalDataSource());

    Get.lazyPut<AmbientRepository>(
      () => AmbientRepositoryImpl(
        localDataSource: Get.find<AmbientLocalDataSource>(),
      ),
    );

    Get.lazyPut<GetAmbientSettings>(
      () => GetAmbientSettings(Get.find<AmbientRepository>()),
    );

    Get.lazyPut<CloseAmbientScreen>(
      () => CloseAmbientScreen(Get.find<AmbientRepository>()),
    );

    Get.lazyPut<AmbientController>(
      () => AmbientController(
        getAmbientSettings: Get.find<GetAmbientSettings>(),
        closeAmbientScreen: Get.find<CloseAmbientScreen>(),
      ),
    );
  }
}
