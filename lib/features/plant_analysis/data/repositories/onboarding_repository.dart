import 'package:myfarm/features/plant_analysis/domain/entities/onboarding_item.dart';

class OnboardingRepository {
  Future<List<OnboardingItem>> fetchOnboardingItems(String langCode) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return [
      OnboardingItem(
        image: 'assets/onboarding1.png',
        titleKey: 'onboarding_title1',
        descKey: 'onboarding_desc1',
      ),
      OnboardingItem(
        image: 'assets/onboarding2.png',
        titleKey: 'onboarding_title2',
        descKey: 'onboarding_desc2',
      ),
      OnboardingItem(
        image: 'assets/onboarding3.png',
        titleKey: 'onboarding_title3',
        descKey: 'onboarding_desc3',
      ),
    ];
  }
}
