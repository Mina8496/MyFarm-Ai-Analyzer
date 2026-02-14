import 'package:get/get.dart';
import 'package:myfarm/features/plant_analysis/data/repositories/onboarding_repository.dart';
import 'package:myfarm/features/plant_analysis/domain/entities/onboarding_item.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  @override
  Future<List<OnboardingItem>> fetchOnboardingItems(String lang) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return [
      OnboardingItem(
        image: 'assets/boarding/theFirst.png',
        titleKey: 'onboard_title1'.tr,
        descKey: 'onboard_desc1'.tr,
      ),
      OnboardingItem(
        image: 'assets/boarding/second.jpg',
        titleKey: 'onboard_title2'.tr,
        descKey: 'onboard_desc2'.tr,
      ),
      OnboardingItem(
        image: 'assets/boarding/third.jpg',
        titleKey: 'onboard_title3'.tr,
        descKey: 'onboard_desc3'.tr,
      ),
    ];
  }
}
