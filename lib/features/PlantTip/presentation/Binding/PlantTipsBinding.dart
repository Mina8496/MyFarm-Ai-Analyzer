import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:myfarm/features/PlantTip/data/dataSource/PlantTipsRemoteDataSource.dart';
import 'package:myfarm/features/PlantTip/data/repo/PlantTipsRepositoryImpl.dart';
import 'package:myfarm/features/PlantTip/data/service/PlantTips_rotation_service.dart';
import 'package:myfarm/features/PlantTip/domin/repo/PlantTipsRepository.dart';
import 'package:myfarm/features/PlantTip/presentation/controller/PlantTipsController.dart';

class PlantTipsBinding extends Bindings {
  @override
  void dependencies() {
    /// Service 
    Get.lazyPut<PlantTipsRotationService>(
      () => PlantTipsRotationService(),
    );
    /// DataSource
    Get.lazyPut(() => PlantTipsRemoteDataSource(FirebaseFirestore.instance));

    /// Repository
    Get.lazyPut<PlantTipsRepository>(() => PlantTipsRepositoryImpl(Get.find()));

    /// Controller
    Get.lazyPut(() => PlantTipsController(Get.find(), Get.find()));
  }
}
