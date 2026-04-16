import 'dart:async';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:myfarm/features/PlantTip/domin/Entity/PlantTip.dart';
import 'package:myfarm/features/PlantTip/domin/repo/PlantTipsRepository.dart';

class PlantTipsController extends GetxController {
  final PlantTipsRepository repository;
  late final StreamSubscription sub;

  PlantTipsController(this.repository);

  var tips = <PlantTip>[].obs;

  @override
  void onInit() {
    super.onInit();

    sub = repository.getPlantTips().listen(
      (data) {
        tips.value = data;
      },
      onError: (e) {
        print(e);
      },
    );
  }

  @override
  void onClose() {
    sub.cancel();
    super.onClose();
  }
}
