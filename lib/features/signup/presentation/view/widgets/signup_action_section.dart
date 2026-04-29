import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myfarm/core/widgets/app_Button.dart';
import 'package:myfarm/core/widgets/app_textView.dart';
import 'package:myfarm/core/widgets/google_button.dart';
import 'package:myfarm/features/signup/domain/usecase/signup_params.dart';
import 'package:myfarm/features/signup/manger/featured_signup_cubit/signup_cubit.dart';
import 'package:myfarm/features/signup/manger/featured_signup_cubit/signup_state.dart';
import 'package:myfarm/features/signup/presentation/controller/signup_controller.dart';
import 'package:myfarm/features/signup/presentation/view/widgets/LoginRedirect.dart';
import 'package:myfarm/features/signup/presentation/view/widgets/location_controller.dart';

class SignupActionSection extends GetView<SignupController> {
  const SignupActionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state is SignupSuccess) {          // ✅ كان AuthSuccess
              Get.offAllNamed('/home');
            } else if (state is SignupError) {     // ✅ كان AuthError
              Get.snackbar("Error", state.message); // ✅ كان errormessage
            }
          },
          builder: (context, state) {
            return AppButton(
              onTap: () {
                if (!controller.formKey.currentState!.validate()) return;

                context.read<SignupCubit>().signup( // ✅ كان FeaturedSignupCubit
                  SignupParams(
                    name: controller.nameController.text,
                    email: controller.emailController.text,
                    password: controller.passwordController.text,
                    phone: controller.phoneController.text,
                    location: Get.find<LocationController>().locationText.value,
                  ),
                );
              },
              textApp: state is SignupLoading      // ✅ كان AuthLoading
                  ? const CircularProgressIndicator()
                  : AppText(text: "Register".tr, color: Colors.white),
            );
          },
        ),
        GoogleButton(),
        LoginRedirect(),
        SizedBox(height: 20.h),
      ],
    );
  }
}