import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';



class DotsIndicator extends StatelessWidget {
  final RxInt currentIndex;
  final int count;

  const DotsIndicator({
    super.key,
    required this.currentIndex,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          count,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            width: currentIndex.value == index ? 18.w : 6.w,
            height: 6.h,
            decoration: BoxDecoration(
              color: currentIndex.value == index ? Colors.amber : Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
