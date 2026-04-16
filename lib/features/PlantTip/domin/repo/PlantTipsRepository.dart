
import 'package:myfarm/features/PlantTip/domin/Entity/PlantTip.dart';

abstract class PlantTipsRepository {
  Future<void> addPlantTip(PlantTip tip);
  Stream<List<PlantTip>> getPlantTips();
}