import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myfarm/features/signup/presentation/view/widgets/textButton_login_and_signin.dart';

class LoginRedirect extends StatelessWidget {
  const LoginRedirect({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButtonLoginAndSignin(
      onPressed: () {
        Get.toNamed('/login', );
      },
      textTitle: 'Do_you_have_account'.tr,
      textbutton: 'Login'.tr,
    );
  }
}