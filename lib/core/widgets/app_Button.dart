import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/common/constants/color_palette.dart';

class AppButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Widget textApp;
  final Color? backgroundColor;

  const AppButton({
    super.key,
    this.onTap,
    required this.textApp,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: backgroundColor ?? ColorPalette.kButtonColor,
            borderRadius: BorderRadius.circular(30.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10.r,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: textApp,
        ),
      ),
    );
  }
}
