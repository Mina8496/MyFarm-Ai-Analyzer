import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myfarm/core/widgets/Input_field.dart';
import 'package:myfarm/core/widgets/Validators.dart';
import 'package:myfarm/core/widgets/app_textView.dart';
import 'package:myfarm/core/widgets/password_field.dart';
import 'package:myfarm/features/login/manger/cubit/login_cubit.dart';

class LoginInputSection extends StatelessWidget {
  const LoginInputSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 40.h),
        AppText(text: 'Please_enter_following_information'.tr),
        SizedBox(height: 12.h),

        /// input Field
        InputField(
          textTitke: "EnterYourEmail".tr,
          controller: cubit.emailController,
          validator: Validators.email,
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 18.h),

        /// Password
        const PasswordField(),
      ],
    );
  }
}
