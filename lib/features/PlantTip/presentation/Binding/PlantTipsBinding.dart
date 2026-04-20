import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:myfarm/core/services/firestore_service.dart';
import 'package:myfarm/features/PlantTip/data/dataSource/PlantTipsRemoteDataSource.dart';
import 'package:myfarm/features/PlantTip/data/model/plantTip_model.dart';
import 'package:myfarm/features/PlantTip/data/repo/PlantTipsRepositoryImpl.dart';
import 'package:myfarm/features/PlantTip/data/service/PlantTips_rotation_service.dart';
import 'package:myfarm/features/PlantTip/domin/repo/PlantTipsRepository.dart';
import 'package:myfarm/features/PlantTip/presentation/controller/PlantTipsController.dart';

class PlantTipsBinding extends Bindings {
  @override
  void dependencies() {
    // Core dependency (Firestore wrapper)
    Get.put<FirestoreService<PlantTipModel>>(
      FirestoreService<PlantTipModel>(FirebaseFirestore.instance),
      permanent: true,
    );

    // Services
    Get.put(PlantTipsRotationService());

    // DataSource
    Get.lazyPut<PlantTipsRemoteDataSource>(
      () => PlantTipsRemoteDataSource(
        Get.find<FirestoreService<PlantTipModel>>(),
      ),
    );

    // Repository
    Get.lazyPut<PlantTipsRepository>(() => PlantTipsRepositoryImpl(Get.find()));

    // Controller
    Get.lazyPut(() => PlantTipsController(Get.find(), Get.find()));
  }
}
