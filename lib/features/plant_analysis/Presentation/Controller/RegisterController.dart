import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordHidden = true.obs;
  var isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone_required".tr;
    }
    return null;
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

  void register() {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    // Call UseCase هنا

    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
    });
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose(); // ← تضيف هذا
    passwordController.dispose();
    super.onClose();
  }
}
