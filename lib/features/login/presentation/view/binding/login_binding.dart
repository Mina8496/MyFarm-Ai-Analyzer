import 'package:get/get.dart';
import 'package:myfarm/features/login/domain/use_cases/login_usecase.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginUseCase>(() => LoginUseCase(Get.find()));
  }
}
