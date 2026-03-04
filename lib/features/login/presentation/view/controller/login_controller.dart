import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/core/services/biometric_service.dart';

class LoginController extends GetxController with SingleGetTickerProviderMixin {
  // -------- Text Controllers --------
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // -------- Form Key --------
  final formKey = GlobalKey<FormState>();
  
  // -------- Biometric --------
  final BiometricService _biometricService = BiometricService();

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

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email_required".tr;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      return "Enter_valid_email".tr;
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return "Password_must".tr;
    }
    return null;
  }

  Future<void> onRegisterPressed() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      // await registerUser(); // UseCase حقيقي
    } finally {
      isLoading.value = false;
    }
  }

  /// Login action (API simulation)
  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2)); // simulate API

    isLoading.value = false;

    Get.snackbar('نجاح', 'تم تسجيل الدخول بنجاح');

    Get.offAllNamed('/home');
  }
/// loginWithBiometric
  Future<void> loginWithBiometric() async {
  final authenticated = await _biometricService.authenticate();

  if (!authenticated) return;

  // هنا تنفذ تسجيل الدخول الحقيقي
  // await loginUseCase.execute(
  //   emailController.text,
  //   passwordController.text,
  // );
}

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    animationController.dispose();
    super.onClose();
  }
}
