import 'package:myfarm/features/PlantTip/domin/Entity/PlantTip.dart';
import 'package:myfarm/features/PlantTip/domin/repo/PlantTipsRepository.dart';

class AddPlantTip {
  final PlantTipsRepository repo;

  AddPlantTip(this.repo);

  Future<void> call(PlantTip tip) {
    return repo.addPlantTip(tip);
  }
}