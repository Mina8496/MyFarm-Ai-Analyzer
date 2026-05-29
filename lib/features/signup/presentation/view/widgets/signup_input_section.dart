// signup_input_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:myfarm/core/widgets/Input_field.dart';
import 'package:myfarm/features/signup/presentation/manger/signup_cubit/signup_cubit.dart';
import 'package:myfarm/features/signup/presentation/manger/signup_cubit/signup_state.dart';

class SignupInputSection extends StatelessWidget {
  const SignupInputSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();

    return Column(
      children: [
        InputField(
          textTitke: 'Your_Name'.tr,
          controller: cubit.nameController,
          validator: cubit.validateName,
          keyboardType: TextInputType.name,
        ),
        InputField(
          textTitke: 'Email_Address'.tr,
          controller: cubit.emailController,
          validator: cubit.validateEmail,
          keyboardType: TextInputType.emailAddress,
        ),
        //  Password مع BlocBuilder للـ Toggle
        BlocBuilder<SignupCubit, SignupState>(
          buildWhen: (prev, curr) => curr is SignupPasswordToggled,
          builder: (context, state) {
            return InputField(
              textTitke: 'Password'.tr,
              controller: cubit.passwordController,
              keyboardType: TextInputType.visiblePassword,
              validator: cubit.validatePassword,
              obscureText: cubit.isPasswordHidden,
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
        InputField(
          textTitke: 'Phone Number',
          controller: cubit.phoneController,
          keyboardType: TextInputType.phone,
          validator: cubit.validatePhone,
          suffixIcon: const Icon(Icons.phone),
        ),
      ],
    );
  }
}