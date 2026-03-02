import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myfarm/core/widgets/Input_field.dart';
import 'package:myfarm/core/widgets/app_textView.dart';
import 'package:myfarm/core/widgets/app_auth_header.dart';
import 'package:myfarm/core/widgets/app_header_rich_text.dart';
import 'package:myfarm/core/widgets/password_field.dart';
import 'package:myfarm/features/login/presentation/view/controller/login_controller.dart';
import 'package:myfarm/features/signup/presentation/view/widgets/RegisterButton.dart';
import 'package:myfarm/features/signup/presentation/view/widgets/textButton_login_and_signin.dart';

class LoginPageBody extends GetView<LoginController> {
  const LoginPageBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Header
          AppAuthHeader(
            child: AppHeaderRichText(
              title_1: 'Login'.tr,
              title_2: 'Welcome'.tr,
            ),
          ),

          SizedBox(height: 40.h),
          AppText(text: 'Please_enter_following_information'.tr),
          SizedBox(height: 12.h),

          /// input Field
          InputField(
            textTitke: "EnterYourEmail".tr,
            controller: controller.emailController,
            validator: controller.validateEmail,
          ),
          SizedBox(height: 18.h),

          /// Password
          const PasswordField(),
// Text Button for forgat password
          TextButtonLoginAndSignin(
            onPressed: () {},
            textbutton: "forget_your_password".tr,
          ),

          /// Login Button
          Center(
            child: RegisterButton(
              controller: controller.isLoading.value
                  ? null
                  : controller.login,
              child: controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : AppText(text: "Login".tr, color: Colors.white),
            ),
          ),

          SizedBox(height: 18.h),

          const Spacer(),
        ],
      ),
    );
  }
}
