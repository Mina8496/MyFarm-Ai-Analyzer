import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:myfarm/features/PlantTip/domin/Entity/PlantTip.dart';
import 'package:myfarm/features/PlantTip/domin/repo/PlantTipsRepository.dart';

class PlantTipsController extends GetxController {
  final PlantTipsRepository repository;

  PlantTipsController(this.repository);

  var tips = <PlantTip>[].obs;

  @override
  void onInit() {
    repository.getPlantTips().listen((data) {
      tips.value = data;
    });
    super.onInit();
  }

  Future<void> addTip() async {
    final tip = PlantTip(
      id: '',
      title: 'Test',
      description: 'Desc',
      imageUrl: '',
    );

    await repository.addPlantTip(tip);
  }
}
