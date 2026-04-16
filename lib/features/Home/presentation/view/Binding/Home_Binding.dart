import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:myfarm/features/PlantTip/data/plantTips_service.dart';
import 'package:myfarm/features/PlantTip/domin/repo/plantTips_repo.dart';
import 'package:myfarm/features/PlantTip/presentation/controller/plantTips_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlantTipsController>(
      () => PlantTipsController(PlantTipsRepoImpl(PlantTipsService())),
    );
  }
}
