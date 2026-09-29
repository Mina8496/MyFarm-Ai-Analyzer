import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeController extends GetxController {
  static const boxName = 'settings';
  static const _key = 'themeMode';

  final mode = ThemeMode.system.obs;

  @override
  void onInit() {
    final saved = Hive.box(boxName).get(_key);
    mode.value = ThemeMode.values.firstWhere(
      (m) => m.name == saved,
      orElse: () => ThemeMode.system,
    );
    super.onInit();
  }

  void setMode(ThemeMode m) {
    mode.value = m;
    Hive.box(boxName).put(_key, m.name);
  }
}