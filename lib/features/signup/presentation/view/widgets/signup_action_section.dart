import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/core/widgets/app_Button.dart';
import 'package:myfarm/core/widgets/app_textView.dart';
import 'package:myfarm/core/widgets/google_button.dart';
import 'package:myfarm/features/signup/presentation/controller/signup_controller.dart';
import 'package:myfarm/features/signup/presentation/view/widgets/LoginRedirect.dart';

class SignupActionSection extends GetView<SignupController> {
  const SignupActionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppButton(
          onTap: () async {
            if (controller.isLoading.value) return;

            // bool registerSuccess = await controller.onRegisterPressed();

            // if (registerSuccess) {
            //   bool biometricEnabled = await controller
            //       .enableBiometricAfterRegister();

            //   if (biometricEnabled) {
            //     final prefs = await SharedPreferences.getInstance();
            //     await prefs.setBool("biometric_enabled", true);
            //   }
            // }
          },
          textApp: controller.isLoading.value
              ? const CircularProgressIndicator()
              : AppText(text: "Register".tr, color: Colors.white),
        ),
        GoogleButton(),
        LoginRedirect(),
      ],
    );
  }
}
