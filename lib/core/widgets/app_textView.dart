import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class AppTextView extends StatelessWidget {
  String? text;
  Color? color;
  double? fontSize;

  AppTextView({super.key, required this.text, this.color, this.fontSize,});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: fontSize ?? 16.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
