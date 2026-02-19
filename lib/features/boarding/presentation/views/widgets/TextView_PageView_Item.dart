import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myfarm/core/widgets/app_textView.dart';
import 'package:myfarm/features/boarding/presentation/views/widgets/PageView_item.dart';

class TextViewPageViewItem extends StatelessWidget {
  const TextViewPageViewItem({super.key, required this.item});

  final PageViewItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppTextView(
            text: item.titleKey.tr,
            color: Colors.white.withOpacity(0.9),
            fontSize: 24.sp,
          ),
          SizedBox(height: 18.h),
          AppTextView(
            text: item.descKey.tr,
            color: Colors.white,
            fontSize: 17.sp,
          ),
        ],
      ),
    );
  }
}
