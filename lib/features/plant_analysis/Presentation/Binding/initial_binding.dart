import 'package:get/get.dart';
import 'package:myfarm/core/localization/translation_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TranslationController());
  }
}