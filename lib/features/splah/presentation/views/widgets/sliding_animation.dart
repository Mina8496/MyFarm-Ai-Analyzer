import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/features/plant_analysis/Presentation/widgets/custom_text.dart';

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
          child: CustomText(
            text: 'My Farm',
            color: Colors.white,
            fontSize: 25.sp,
          ),
        );
      },
    );
  }
}
