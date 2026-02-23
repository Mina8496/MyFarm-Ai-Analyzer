import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:myfarm/core/widgets/app_textView.dart';
import 'package:myfarm/core/widgets/app_text_feild.dart';
import 'package:myfarm/features/register/presentation/controller/register_controller.dart';

class PasswordField extends GetView<RegisterController> {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(text: "Password".tr, color: Colors.black),

        Obx(
          () => AppTextField(
            controller: controller.passwordController,
            obscureText: controller.isPasswordHidden.value,
            validator: controller.validatePassword,
            suffixIcon: IconButton(
              icon: Icon(
                controller.isPasswordHidden.value
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
              onPressed: controller.togglePasswordVisibility,
            ),
          ),
        ),
      ],
    );
  }
}