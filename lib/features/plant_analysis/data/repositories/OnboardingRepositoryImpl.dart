import 'package:get/get.dart';
import 'package:myfarm/features/plant_analysis/data/repositories/onboarding_repository.dart';
import 'package:myfarm/features/boarding/presentation/views/widgets/PageView_item.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  @override
  Future<List<PageViewItem>> fetchOnboardingItems(String lang) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return [
      PageViewItem(
        image: 'assets/boarding/theFirst.png',
        titleKey: 'onboard_title1'.tr,
        descKey: 'onboard_desc1'.tr,
      ),
      PageViewItem(
        image: 'assets/boarding/second.jpg',
        titleKey: 'onboard_title2'.tr,
        descKey: 'onboard_desc2'.tr,
      ),
      PageViewItem(
        image: 'assets/boarding/third.jpg',
        titleKey: 'onboard_title3'.tr,
        descKey: 'onboard_desc3'.tr,
      ),
    ];
  }
}
