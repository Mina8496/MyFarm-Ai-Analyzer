import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/AppConfig.dart';

class TranslationController extends GetxController {
  /// اللغة الحالية
  RxString currentLang = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _setDeviceLanguage();
  }

  /// يحدد لغة الجهاز تلقائياً عند بدء التطبيق
  void _setDeviceLanguage() {
    currentLang.value =
        Get.deviceLocale?.languageCode ??
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;

    AppConfig.lang = currentLang.value;
    Get.updateLocale(Locale(currentLang.value));
  }

  /// لتغيير اللغة يدوياً لو احتجت مستقبلاً
  void changeLanguage(String langCode) {
    currentLang.value = langCode;
    Get.updateLocale(Locale(langCode));
  }
}
