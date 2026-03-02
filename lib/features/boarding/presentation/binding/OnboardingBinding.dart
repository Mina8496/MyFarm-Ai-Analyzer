import 'package:get/get.dart';
import 'package:myfarm/features/boarding/presentation/viewModel/OnboardingRepositoryImpl.dart';
import '../controllers/controller_onboarding.dart';
import '../viewModel/onboarding_repository.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingRepository>(() => OnboardingRepositoryImpl());

    Get.lazyPut<ControllerOnboardingPage>(
      () => ControllerOnboardingPage(repository: Get.find()),
    );
  }
}
