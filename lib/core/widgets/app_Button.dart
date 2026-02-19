import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/common/constants/color_palette.dart';

class AppButton extends StatelessWidget {
  final GestureTapCallback? controller;
  final Widget child;

  const AppButton({super.key, required this.controller, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: ColorPalette.kButtonColor,
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10.r,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
