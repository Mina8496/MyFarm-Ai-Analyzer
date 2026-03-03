import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myfarm/core/widgets/app_Button.dart';
import 'package:myfarm/core/widgets/app_auth_header.dart';
import 'package:myfarm/core/widgets/app_header_rich_text.dart';
import 'package:myfarm/core/widgets/app_textView.dart';
import 'package:myfarm/core/widgets/app_text_feild.dart';

class ForgetPasswordBody extends StatelessWidget {
  const ForgetPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppAuthHeader(
          child: AppHeaderRichText(title_1: "", title_2: "Account_recovery".tr),
        ),
        SizedBox(height: 25.h),
        AppText(text: "Email_required".tr, textAlign: TextAlign.start),
        SizedBox(height: 20.h),

        AppTextField(keyboardType: TextInputType.emailAddress),
        SizedBox(height: 30.h),
        AppButton(
          textApp: AppText(
            text: "Sending_requires_confirmation".tr,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
