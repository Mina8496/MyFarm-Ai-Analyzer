import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:myfarm/core/widgets/app_textView.dart';
import 'package:myfarm/features/auth/presentation/widgets/google_button.dart';
import 'package:myfarm/features/signup/presentation/controller/signup_controller.dart';
import 'package:myfarm/features/signup/presentation/view/widgets/LoginRedirect.dart';
import 'package:myfarm/features/signup/presentation/view/widgets/RegisterButton.dart';

class SignupActionSection extends GetView<SignupController> {
  const SignupActionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RegisterButton(
          controller: controller.isLoading.value
              ? null
              : controller.onRegisterPressed,

          child: controller.isLoading.value
              ? const CircularProgressIndicator()
              : AppText(text: "Register".tr, color: Colors.white),
        ),
        GoogleButton(),
        LoginRedirect(),
      ],
    );
  }
}
