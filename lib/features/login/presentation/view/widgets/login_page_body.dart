import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myfarm/core/widgets/app_Button.dart';
import 'package:myfarm/core/widgets/app_textView.dart';
import 'package:myfarm/core/widgets/app_auth_header.dart';
import 'package:myfarm/core/widgets/app_header_rich_text.dart';
import 'package:myfarm/core/widgets/google_button.dart';
import 'package:myfarm/features/login/manger/cubit/login_cubit.dart';
import 'package:myfarm/features/login/manger/cubit/login_state.dart';
import 'package:myfarm/features/login/presentation/view/controller/login_controller.dart';
import 'package:myfarm/features/login/presentation/view/widgets/login_input_section.dart';
import 'package:myfarm/features/signup/presentation/view/widgets/textButton_login_and_signin.dart';

class LoginPageBody extends GetView<LoginController> {
  const LoginPageBody({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Get.offAllNamed('/home');
        } else if (state is LoginError) {
          Get.snackbar('Error', state.message);
        }
      },
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Header
            AppAuthHeader(
              title: AppHeaderRichText(
                title_1: 'Login'.tr,
                title_2: 'Welcome'.tr,
              ),
            ),

            LoginInputSection(),
            // Text Button for forgat password
            TextButtonLoginAndSignin(
              onPressed: () {
                Get.toNamed("/forgetpassword");
              },
              textbutton: "forget_your_password".tr,
            ),

            /// Login Button
            Center(
              child: BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return AppButton(
                    onTap: () {
                      if (!controller.formKey.currentState!.validate()) return;
                      context.read<LoginCubit>().login();
                    },
                    textApp: state is LoginLoading
                        ? const CircularProgressIndicator()
                        : AppText(text: "Login".tr, color: Colors.white),
                  );
                },
              ),
            ),

            SizedBox(height: 18.h),
            Center(child: GoogleButton()),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
