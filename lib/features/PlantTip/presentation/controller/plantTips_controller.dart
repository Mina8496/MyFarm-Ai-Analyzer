import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:myfarm/features/PlantTip/domin/model/plantTip_model.dart';
import 'package:myfarm/features/PlantTip/domin/repo/plantTips_repo.dart';

class PlantTipsController extends GetxController {
  final PlantTipsRepo repo;

  PlantTipsController(this.repo);

  var tips = <PlantTipModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchTips();
    super.onInit();
  }

  Future <void> fetchTips() async {
    isLoading.value = true;
    tips.value = await repo.getTips();
    isLoading.value = false;
  }
}
