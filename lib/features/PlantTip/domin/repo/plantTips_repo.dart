import 'package:myfarm/features/PlantTip/data/plantTips_service.dart';
import 'package:myfarm/features/PlantTip/domin/model/plantTip_model.dart';

abstract class PlantTipsRepo {
  Future<List<PlantTipModel>> getTips();
}

class PlantTipsRepoImpl implements PlantTipsRepo {
  final PlantTipsService service;

  PlantTipsRepoImpl(this.service);

  @override
  Future<List<PlantTipModel>> getTips() {
    return service.getTips();
  }
}
