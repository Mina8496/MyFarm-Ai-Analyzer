import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/AppConfig.dart';
import 'package:myfarm/features/plant_analysis/data/repositories/onboarding_repository.dart';
import 'package:myfarm/features/boarding/presentation/views/widgets/PageView_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerOnboardingPage extends GetxController {
  final OnboardingRepository repository;

  ControllerOnboardingPage({required this.repository});

  final RxList<PageViewItem> items = <PageViewItem>[].obs;
  final RxInt currentIndex = 0.obs;
  final RxBool isLoading = true.obs;
  int get current => currentIndex.value;

  bool get isFirst => current == 0;
  bool get isLast => current == items.length - 1;

  String get nextTitle => isFirst ? "Next".tr : "Continue".tr;

  final PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    loadOnboardingItems();
  }

  Future<void> loadOnboardingItems() async {
    try {
      final lang = AppConfig.lang;
      final fetchedItems = await repository.fetchOnboardingItems(lang);
      items.assignAll(fetchedItems);
    } finally {
      isLoading.value = false;
    }
  }

  void nextPage() {
    if (currentIndex.value < items.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (currentIndex.value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> startApp() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);
    Get.offAllNamed('/user_type');
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
