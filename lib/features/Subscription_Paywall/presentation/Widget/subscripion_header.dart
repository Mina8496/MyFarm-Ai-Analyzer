import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myfarm/core/widgets/app_textView.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/Widget/achievements_section.dart';

class SubscripionHeader extends StatelessWidget {
  const SubscripionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Top Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_circleButton(context)],
          ),
          SizedBox(height: 60.h),

          Center(
            child: AppText(
              text: "Unlimited_Access".tr,
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Center(
            child: AppText(
              text: "Access_AI".tr,
              fontSize: 18,
              color: Colors.white70,
            ),
          ),

          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AchievementsSection(
                subtext: 'FEATURED_IN'.tr,
                text: 'COUNTRIES'.tr,
              ),
              SizedBox(width: 10.w),
              AchievementsSection(subtext: 'APP_OF_THE'.tr, text: 'month'.tr),
            ],
          ),
        ],
      ),
    );
  }

  Widget _circleButton(context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black45,
      ),
      child: IconButton(
        onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        icon: const Icon(Icons.close, color: Colors.white),
      ),
    );
  }
}
