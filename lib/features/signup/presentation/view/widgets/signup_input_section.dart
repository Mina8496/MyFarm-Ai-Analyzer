import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:myfarm/core/widgets/Input_field.dart';
import 'package:myfarm/core/widgets/password_field.dart';
import 'package:myfarm/features/signup/presentation/controller/signup_controller.dart';
import 'package:myfarm/features/signup/presentation/view/widgets/location_signup_field.dart';

class SignupInputSection extends GetView<SignupController> {
  const SignupInputSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputField(
          textTitke: 'Your_Name'.tr,
          controller: controller.nameController,
          validator: controller.validateName,
        ),

        InputField(
          textTitke: 'Email_Address'.tr,
          controller: controller.emailController,
          validator: controller.validateEmail,
        ),

        const PasswordField(),

        InputField(
          textTitke: 'Phone_Number'.tr,
          controller: controller.phoneController,
          keyboardType: TextInputType.phone,
          validator: controller.validatePhone,
          suffixIcon: const Icon(Icons.phone),
        ),

        // Location Field
        const LocationSignupField(),
      ],
    );
  }
}
