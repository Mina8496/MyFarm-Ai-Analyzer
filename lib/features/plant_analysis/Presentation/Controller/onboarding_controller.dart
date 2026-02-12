import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/AppConfig.dart';
import 'package:myfarm/features/plant_analysis/Presentation/Controller/TranslationController.dart';
import 'package:myfarm/features/plant_analysis/data/repositories/onboarding_repository.dart';
import 'package:myfarm/features/plant_analysis/domain/entities/onboarding_item.dart';


class OnboardingController extends GetxController {
  final OnboardingRepository repository;
  final TranslationController translationController;

  OnboardingController({
    required this.repository,
    required this.translationController,
  });

  RxList<OnboardingItem> items = <OnboardingItem>[].obs;
  PageController pageController = PageController();
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadOnboardingItems();
  }

  Future<void> loadOnboardingItems() async {
    final lang = AppConfig.lang;
    final fetchedItems = await repository.fetchOnboardingItems(lang);
    items.assignAll(fetchedItems);
  }

  void onPageChanged() {
    if (currentIndex.value < items.length - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void onBack() {
    if (currentIndex.value > 0) {
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void startApp() {
    // هنا تقدر توجه المستخدم للصفحة الرئيسية
    Get.offAllNamed('/home');
  }
}
