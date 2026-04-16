

import 'package:myfarm/features/PlantTip/data/dataSource/PlantTipsRemoteDataSource.dart';
import 'package:myfarm/features/PlantTip/domin/Entity/PlantTip.dart';
import 'package:myfarm/features/PlantTip/domin/repo/PlantTipsRepository.dart';

class PlantTipsRepositoryImpl implements PlantTipsRepository {
  final PlantTipsRemoteDataSource remote;

  PlantTipsRepositoryImpl(this.remote);


  @override
  Stream<List<PlantTip>> getPlantTips() {
    return remote.getPlantTips();
  }
}