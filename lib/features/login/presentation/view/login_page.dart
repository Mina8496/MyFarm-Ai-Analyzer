import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myfarm/features/login/presentation/view/controller/login_controller.dart';
import 'package:myfarm/features/login/presentation/view/widgets/login_page_body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      body: FadeTransition(
        opacity: controller.fadeAnimation,
        child: LoginPageBody(),
      ),
    );
  }
}
