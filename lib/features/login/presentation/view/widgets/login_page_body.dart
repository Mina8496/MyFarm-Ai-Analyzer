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
import 'package:myfarm/features/login/presentation/view/widgets/login_input_section.dart';
import 'package:myfarm/features/signup/presentation/view/widgets/textButton_login_and_signin.dart';

class LoginPageBody extends StatelessWidget {
  LoginPageBody({super.key});

  final _formKey = GlobalKey<FormState>();

  void _submitLogin(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    context.read<LoginCubit>().login();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Get.offAllNamed('/home');
        } else if (state is LoginError) {
          Get.snackbar('Error', state.message);
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppAuthHeader(
                title: AppHeaderRichText(
                  title_1: 'Login'.tr,
                  title_2: 'Welcome'.tr,
                ),
              ),
              const LoginInputSection(),
              TextButtonLoginAndSignin(
                onPressed: () => Get.toNamed('/forgetpassword'),
                textbutton: 'forget_your_password'.tr,
              ),
              Center(
                child: AppButton(
                  onTap: () => _submitLogin(context),
                  textApp: state is LoginLoading
                      ? const CircularProgressIndicator()
                      : AppText(text: 'Login'.tr, color: Colors.white),
                ),
              ),
              SizedBox(height: 18.h),
              const Center(child: GoogleButton()),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }
}
