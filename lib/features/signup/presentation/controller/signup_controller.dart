import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
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

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Name_required".tr;
    }

    if (value.trim().length < 3) {
      return "Name_too_short".tr;
    }

    final nameRegex = RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$');

    if (!nameRegex.hasMatch(value.trim())) {
      return "Enter_valid_name".tr;
    }

    return null;
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

  Future<void> onRegisterPressed() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      // await registerUser(); // UseCase حقيقي
    } finally {
      isLoading.value = false;
    }
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
