import 'package:get/get.dart';
import 'package:myfarm/features/plant_analysis/data/repositories/OnboardingRepositoryImpl.dart';
import '../Controller/onboarding_controller.dart';
import '../../data/repositories/onboarding_repository.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingRepository>(() => OnboardingRepositoryImpl());

    Get.lazyPut<OnboardingPageController>(
      () => OnboardingPageController(repository: Get.find()),
    );
  }
}
