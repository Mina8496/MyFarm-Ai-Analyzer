import 'package:myfarm/features/PlantTip/domin/Entity/PlantTip.dart';

abstract class PlantTipsRepository {
  Stream<List<PlantTip>> getPlantTips();
}
