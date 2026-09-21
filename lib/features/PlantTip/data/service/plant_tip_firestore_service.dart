import 'package:myfarm/core/services/firestore_service.dart';
import 'package:myfarm/features/PlantTip/data/model/plant_tip_model.dart';

class PlantTipFirestoreService {
  final FirestoreService<PlantTipModel> service;

  PlantTipFirestoreService(this.service);
}