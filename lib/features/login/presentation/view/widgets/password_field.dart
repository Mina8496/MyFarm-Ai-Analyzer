import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myfarm/core/widgets/Validators.dart';
import 'package:myfarm/core/widgets/app_textView.dart';
import 'package:myfarm/core/widgets/app_text_feild.dart';
import 'package:myfarm/features/signup/presentation/manger/signup_cubit/signup_cubit.dart';
import 'package:myfarm/features/signup/presentation/manger/signup_cubit/signup_state.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(text: "Password".tr, color: Colors.black),

        BlocBuilder<SignupCubit, SignupState>(
          buildWhen: (previous, current) => current is SignupPasswordToggled,
          builder: (context, state) {
            return AppTextField(
              controller: cubit.passwordController,
              obscureText: cubit.isPasswordHidden,
              validator: Validators.password,
              keyboardType: TextInputType.visiblePassword,
              suffixIcon: IconButton(
                icon: Icon(
                  cubit.isPasswordHidden
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: cubit.togglePasswordVisibility,
              ),
            );
          },
        ),
      ],
    );
  }
}
