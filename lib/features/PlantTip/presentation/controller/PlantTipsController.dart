import 'dart:async';
import 'package:get/get.dart';
import 'package:myfarm/features/PlantTip/domin/Entity/PlantTip.dart';
import 'package:myfarm/features/PlantTip/domin/repo/PlantTipsRepository.dart';

class PlantTipsController extends GetxController {
  final PlantTipsRepository repository;
  PlantTipsController(this.repository);

  var tips = <PlantTip>[].obs;

  var visibleTips = <PlantTip>[].obs;

  int _currentIndex = 0;
  Timer? _timer;

  late final StreamSubscription sub;

  @override
  void onInit() {
    super.onInit();

    sub = repository.getPlantTips().listen(
      (data) {
        tips.value = data;

        _startRotation();
      },
      onError: (e) {
        print(e);
      },
    );
  }

  void _startRotation() {
    _timer?.cancel();

    if (tips.length <= 2) {
      visibleTips.value = tips;
      return;
    }

    _updateVisible();

    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      _updateVisible();
    });
  }

  void _updateVisible() {
    if (tips.isEmpty) return;

    final start = _currentIndex;
    final end = (_currentIndex + 2) % tips.length;

    if (end > start) {
      visibleTips.value = tips.sublist(start, end);
    } else {
      visibleTips.value = [...tips.sublist(start), ...tips.sublist(0, end)];
    }

    _currentIndex = (_currentIndex + 2) % tips.length;
  }

  @override
  void onClose() {
    sub.cancel();
    _timer?.cancel();
    super.onClose();
  }
}
