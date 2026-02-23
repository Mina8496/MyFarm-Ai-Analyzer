import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/core/widgets/app_textView.dart';

class ButtonContent extends StatelessWidget {
  const ButtonContent({
    super.key,
    required this.text,
    this.icon,
    this.iconFirst = false,
    this.col,
  });

  final String text;
  final IconData? icon;
  final bool iconFirst;
  final Color? col;

  @override
  Widget build(BuildContext context) {
    final textWidget = AppText(text: text, color: col);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null && iconFirst) ...[
          Icon(icon, size: 18.sp, color: Colors.white),
          SizedBox(width: 10.w),
        ],
        textWidget,
        if (icon != null && !iconFirst) ...[
          SizedBox(width: 10.w),
          Icon(icon, size: 18.sp, color: col ?? Colors.white),
        ],
      ],
    );
  }
}
