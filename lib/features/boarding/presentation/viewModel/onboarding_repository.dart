import 'package:myfarm/features/boarding/presentation/views/widgets/PageView_item.dart';

class OnboardingRepository {
  Future<List<PageViewItem>> fetchOnboardingItems(String langCode) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return [
      PageViewItem(
        image: 'assets/onboarding1.png',
        titleKey: 'onboarding_title1',
        descKey: 'onboarding_desc1',
      ),
      PageViewItem(
        image: 'assets/onboarding2.png',
        titleKey: 'onboarding_title2',
        descKey: 'onboarding_desc2',
      ),
      PageViewItem(
        image: 'assets/onboarding3.png',
        titleKey: 'onboarding_title3',
        descKey: 'onboarding_desc3',
      ),
    ];
  }
}
