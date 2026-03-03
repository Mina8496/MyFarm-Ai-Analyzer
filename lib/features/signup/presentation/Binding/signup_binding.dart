import 'package:get/get.dart';
import 'package:myfarm/features/signup/presentation/view/widgets/location_controller.dart';
import '../controller/signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(() => SignupController());
    Get.lazyPut<LocationController>(() => LocationController());
  }
}
