import 'package:get/get.dart';
import 'package:myfarm/core/storage/app_storage.dart';

class UserTypeController extends GetxController {
  RxString selectedUser = ''.obs;

  void selectUser(String code) {
    selectedUser.value = code;
  }

  void confirmUser() async {
    await AppStorage.saveUserType(selectedUser.value);
    Get.offAllNamed('/onboarding');
  }
}
