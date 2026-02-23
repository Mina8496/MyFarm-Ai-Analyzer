import 'package:get/get.dart';
import 'package:myfarm/features/register/presentation/controller/location_register_controller.dart';
import '../controller/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
    Get.lazyPut<LocationController>(() => LocationController());
  }
}