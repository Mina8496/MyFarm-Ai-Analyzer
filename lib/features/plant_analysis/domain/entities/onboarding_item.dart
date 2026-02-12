import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingItem {
  final String image;
  final String titleKey; // key for translation
  final String descKey;  // key for translation

  OnboardingItem({
    required this.image,
    required this.titleKey,
    required this.descKey,
  });
}

class OnboardingController extends GetxController {
  var currentIndex = 0.obs;

  late PageController pageController;

  /// قائمة العناصر في الأون بوردينج
  final List<OnboardingItem> items = [
    OnboardingItem(
      image: 'assets/images/onboard1.png',
      titleKey: 'onboard_title1',
      descKey: 'onboard_desc1',
    ),
    OnboardingItem(
      image: 'assets/images/onboard2.png',
      titleKey: 'onboard_title2',
      descKey: 'onboard_desc2',
    ),
    OnboardingItem(
      image: 'assets/images/onboard3.png',
      titleKey: 'onboard_title3',
      descKey: 'onboard_desc3',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  /// الانتقال للصفحة التالية
  void onNext() {
    if (currentIndex.value < items.length - 1) {
      pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  /// الانتقال للصفحة السابقة
  void onBack() {
    if (currentIndex.value > 0) {
      pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  /// عند الضغط على Start في الصفحة الأخيرة
  void startApp() {
    // هنا توجه المستخدم للصفحة الرئيسية
    Get.offAllNamed('/home');
  }
}
