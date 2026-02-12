import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController with SingleGetTickerProviderMixin {
  // -------- Text Controllers --------
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  // -------- Form Key --------
  final formKey = GlobalKey<FormState>();

  // -------- State --------
  final isPasswordHidden = true.obs;
  final isLoading = false.obs;

  // -------- Animation --------
  late AnimationController animationController;
  late Animation<double> fadeAnimation;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    fadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );

    animationController.forward();
  }
  // ================= FUNCTIONS =================

  /// Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  /// Validate phone number
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'من فضلك ادخل رقم الموبايل';
    }
    if (value.length < 10) {
      return 'رقم الموبايل غير صحيح';
    }
    return null;
  }

  /// Validate password
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'من فضلك ادخل كلمة المرور';
    }
    if (value.length < 6) {
      return 'كلمة المرور ضعيفة';
    }
    return null;
  }

  /// Login action (API simulation)
  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2)); // simulate API

    isLoading.value = false;

    Get.snackbar('نجاح', 'تم تسجيل الدخول بنجاح');
    // Get.offAllNamed('/home');
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    animationController.dispose();
    super.onClose();
  }
}
