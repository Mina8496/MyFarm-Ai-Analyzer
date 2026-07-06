import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:myfarm/core/widgets/app_Button.dart';
import 'package:myfarm/core/widgets/app_textView.dart';
import 'package:myfarm/core/widgets/google_button.dart';
import 'package:myfarm/features/signup/presentation/manger/signup_cubit/signup_cubit.dart';
import 'package:myfarm/features/signup/presentation/manger/signup_cubit/signup_state.dart';
import 'package:myfarm/features/signup/presentation/view/widgets/LoginRedirect.dart';

class SignupActionSection extends StatelessWidget {
  const SignupActionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess || state is SignupGoogleSignInSuccess) {
          Get.offAllNamed('/SubPage');
        } else if (state is SignupError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is SignupLoading;

        return Column(
          children: [
            AppButton(
              onTap: isLoading
                  ? null
                  : () => context.read<SignupCubit>().signup(),
              textApp: isLoading
                  ? const CircularProgressIndicator()
                  : AppText(text: "Register", color: Colors.white),
            ),
            Center(
              child: GoogleButton(
                onTap: () {
                  context.read<SignupCubit>().signInWithGoogle();
                },
              ),
            ),
            const LoginRedirect(),
            SizedBox(height: 20.h),
          ],
        );
      },
    );
  }
}
