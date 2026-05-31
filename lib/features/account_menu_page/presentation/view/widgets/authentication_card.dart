import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/utils/styles.dart';

class AuthenticationCard extends StatelessWidget {
  const AuthenticationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        width: double.infinity,
        height: 150.h,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: ColorPalette.kPrimaryGray,
              child: Icon(Icons.person, size: 40, color: Colors.white),
            ),
            SizedBox(width: 20.w),
            GestureDetector(
              onTap: () => Get.toNamed("/signup"),
              child: Text(
                "تسجيل الدخول / التسجيل",
                style: Styles.style20.copyWith(color: Colors.grey.shade700),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
