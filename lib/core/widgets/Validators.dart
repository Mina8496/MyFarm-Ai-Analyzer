import 'package:get/get_utils/src/extensions/internacionalization.dart';

class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) return "Email_required".tr;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return "Enter_valid_email".tr;
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.length < 6) return "Password_must".tr;
    return null;
  }
}