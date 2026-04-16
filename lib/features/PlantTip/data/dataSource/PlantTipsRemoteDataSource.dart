import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfarm/features/PlantTip/data/model/plantTip_model.dart';

class PlantTipsRemoteDataSource {
  final FirebaseFirestore firestore;

  PlantTipsRemoteDataSource(this.firestore);


  Stream<List<PlantTipModel>> getPlantTips() {
    return firestore.collection('plantTips').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return PlantTipModel.fromJson(doc.data(), doc.id);
      }).toList();
    });
  }
}