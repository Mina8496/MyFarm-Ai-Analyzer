import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as fontawesome;
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:myfarm/core/utils/Asset_Paths.dart';
import 'package:myfarm/core/widgets/auth_header.dart';
import 'package:myfarm/core/widgets/button_content.dart';
import 'package:myfarm/core/widgets/app_Button.dart';
import 'package:myfarm/core/widgets/app_textView.dart';
import 'package:myfarm/features/register/presentation/controller/register_controller.dart';
import 'package:myfarm/features/register/presentation/view/widgets/header_rich_text_register.dart';
import 'package:myfarm/features/register/presentation/view/widgets/RegisterInputField.dart';
import 'package:myfarm/features/register/presentation/view/widgets/location_field.dart';
import 'package:myfarm/features/register/presentation/view/widgets/password_field.dart';
import 'package:myfarm/features/register/presentation/view/widgets/textButton_login_and_signin.dart';

class RegisterPageBody extends GetView<RegisterController> {
  const RegisterPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            AuthHeader(
              backgroundImage: AssetPaths.backGround_1,
              child: HeaderRichTextRegister(),
            ),
            _InputSection(),
            _ActionSection(),
          ],
        ),
      ),
    );
  }
}

class _InputSection extends GetView<RegisterController> {
  const _InputSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RegisterInputField(
          textTitke: 'Your_Name'.tr,
          controller: controller.nameController,
          validator: controller.validateName,
        ),

        RegisterInputField(
          textTitke: 'Email_Address'.tr,
          controller: controller.emailController,
          validator: controller.validateEmail,
        ),

        const PasswordField(),

        RegisterInputField(
          textTitke: 'Phone_Number'.tr,
          controller: controller.phoneController,
          keyboardType: TextInputType.phone,
          validator: controller.validatePhone,
          suffixIcon: const Icon(Icons.phone),
        ),

        // Location Field
        const LocationField(),
      ],
    );
  }
}

class _ActionSection extends StatelessWidget {
  const _ActionSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12.h),
        _RegisterButton(),
        SizedBox(height: 6.h),
        _GoogleButton(),
        SizedBox(height: 3.h),
        _LoginRedirect(),
      ],
    );
  }
}

class _RegisterButton extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppButton(
        controller: controller.isLoading.value
            ? null
            : controller.onRegisterPressed,
        child: controller.isLoading.value
            ? const CircularProgressIndicator()
            : AppText(text: "Register".tr),
      ),
    );
  }
}

class _GoogleButton extends StatelessWidget {
  const _GoogleButton();

  @override
  Widget build(BuildContext context) {
    return AppButton(
      controller: () async {
        // Google SignIn
      },
      backgroundColor: Colors.white,
      child: ButtonContent(
        text: "Continue with Google",
        col: Colors.black,
        icon: fontawesome.FontAwesomeIcons.google,
      ),
    );
  }
}

class _LoginRedirect extends StatelessWidget {
  const _LoginRedirect();

  @override
  Widget build(BuildContext context) {
    return TextButtonLoginAndSignin(
      onPressed: () {
        Get.toNamed('/login');
      },
      textTitle: 'Do_you_have_account'.tr,
      textbutton: 'Login'.tr,
    );
  }
}
