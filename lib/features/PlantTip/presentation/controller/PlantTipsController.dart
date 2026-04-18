import 'dart:async';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:myfarm/features/PlantTip/data/service/PlantTips_rotation_service.dart';
import 'package:myfarm/features/PlantTip/domin/Entity/PlantTip.dart';
import 'package:myfarm/features/PlantTip/domin/repo/PlantTipsRepository.dart';

class PlantTipsController extends GetxController {
  final PlantTipsRepository repository;
  final PlantTipsRotationService rotationService;

  PlantTipsController(this.repository, this.rotationService);

  var tips = <PlantTip>[].obs;
  var visibleTips = <PlantTip>[].obs;
  var isLoading = true.obs;

  Timer? _timer;
  late final StreamSubscription sub;

  @override
  void onInit() {
    super.onInit();

    sub = repository.getPlantTips().listen((data) {
      tips.value = data;
isLoading.value = false;
      _startRotation();
    });
  }

  void _startRotation() {
    _timer?.cancel();

    if (tips.length <= 2) {
      visibleTips.value = tips;
      return;
    }

    _update();

    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      _update();
    });
  }

  void _update() {
    visibleTips.value = rotationService.getNext(tips);
  }

  @override
  void onClose() {
    sub.cancel();
    _timer?.cancel();
    super.onClose();
  }
}
