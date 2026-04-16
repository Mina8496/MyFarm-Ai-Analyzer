

import 'package:myfarm/features/PlantTip/data/dataSource/PlantTipsRemoteDataSource.dart';
import 'package:myfarm/features/PlantTip/data/model/plantTip_model.dart';
import 'package:myfarm/features/PlantTip/domin/Entity/PlantTip.dart';
import 'package:myfarm/features/PlantTip/domin/repo/PlantTipsRepository.dart';

class PlantTipsRepositoryImpl implements PlantTipsRepository {
  final PlantTipsRemoteDataSource remote;

  PlantTipsRepositoryImpl(this.remote);

  @override
  Future<void> addPlantTip(PlantTip tip) async {
    final model = PlantTipModel(
      id: tip.id,
      title: tip.title,
      description: tip.description,
      imageUrl: tip.imageUrl,
    );
    await remote.addPlantTip(model);
  }

  @override
  Stream<List<PlantTip>> getPlantTips() {
    return remote.getPlantTips();
  }
}