import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/core/widgets/app_textView.dart';

class SlidingAnimation extends StatelessWidget {
  const SlidingAnimation({super.key, required this.slidingAnimation});

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slidingAnimation,
      builder: (context, _) {
        return SlideTransition(
          position: slidingAnimation,
          child: AppTextView(
            text: 'My Farm',
            color: Colors.white,
            fontSize: 25.sp,
          ),
        );
      },
    );
  }
}
