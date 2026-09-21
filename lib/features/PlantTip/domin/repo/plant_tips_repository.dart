import 'package:myfarm/features/PlantTip/domin/Entity/plant_tip.dart';

abstract class PlantTipsRepository {
  Stream<List<PlantTip>> getPlantTips();
}
