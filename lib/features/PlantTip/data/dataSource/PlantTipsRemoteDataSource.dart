import 'package:myfarm/core/services/firestore_service.dart';
import 'package:myfarm/features/PlantTip/data/model/plantTip_model.dart';

class PlantTipsRemoteDataSource {
  final FirestoreService<PlantTipModel> service;

  PlantTipsRemoteDataSource(this.service);

  Stream<List<PlantTipModel>> getPlantTips() {
    return service.getData(
      collectionName: 'plantTips',
      fromJson: (json, id) => PlantTipModel.fromJson(json, id),
    );
  }
}
