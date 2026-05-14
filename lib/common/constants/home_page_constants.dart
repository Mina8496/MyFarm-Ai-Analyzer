import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const double kWeatherCardTop    = 180;
const double kHorizontalPadding = 29;
final double  kWeatherCardOffset = 110.h;
final double  kErrorPaddingH    = 24.w;
final double  kErrorIconSize    = 80.sp;
const String  kRetryHint = 'تأكد من اتصال الإنترنت ثم حاول مرة أخرى';

final errorTitleStyle = TextStyle(
  fontSize: 20.sp,
  fontWeight: FontWeight.bold,
  color: Colors.black87,
);

final errorSubtitleStyle = TextStyle(
  fontSize: 15.sp,
  color: Colors.grey.shade700,
);