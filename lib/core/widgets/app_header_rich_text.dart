import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppHeaderRichText extends StatelessWidget {
  final String title_1;
  final String title_2;
  const AppHeaderRichText({
    super.key,
    required this.title_1,
    required this.title_2,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: title_1,
        style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
        children: [
          TextSpan(text: '\n'),
          TextSpan(text: title_2),
        ],
      ),
    );
  }
}
