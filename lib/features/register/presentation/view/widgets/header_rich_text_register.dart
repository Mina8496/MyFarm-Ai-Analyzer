import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HeaderRichTextRegister extends StatelessWidget {
  const HeaderRichTextRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Create_Account'.tr,
        style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
        children: [
          TextSpan(text: '\n'),
          TextSpan(text: 'Let’s_Create_Account_Together'.tr),
        ],
      ),
    );
  }
}
