import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/AppConfig.dart';
import 'package:myfarm/features/plant_analysis/data/repositories/onboarding_repository.dart';
import 'package:myfarm/features/plant_analysis/domain/entities/onboarding_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPageController extends GetxController {
  final OnboardingRepository repository;

  OnboardingPageController({required this.repository});

  final RxList<OnboardingItem> items = <OnboardingItem>[].obs;
  final RxInt currentIndex = 0.obs;
  final RxBool isLoading = true.obs;

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
