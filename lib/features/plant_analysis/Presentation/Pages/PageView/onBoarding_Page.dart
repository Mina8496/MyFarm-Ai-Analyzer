import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myfarm/features/plant_analysis/Presentation/widgets/dots_indicator.dart';
import 'package:myfarm/features/plant_analysis/Presentation/widgets/single_Button.dart';
import 'package:myfarm/features/plant_analysis/domain/entities/onboarding_item.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingController = Get.find<OnboardingController>();

    return Scaffold(
      backgroundColor: const Color(0xFF2F353C),
      body: SafeArea(
        child: Column(
          children: [
            /// Pages
            Expanded(
              child: PageView.builder(
                controller: onboardingController.pageController,
                onPageChanged: (index) =>
                    onboardingController.currentIndex.value = index,
                itemCount: onboardingController.items.length,
                itemBuilder: (_, index) {
                  final item = onboardingController.items[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 50.h),
                        Image.asset(item.image, height: 300.h, width: 300.w),
                        SizedBox(height: 24.h),
                        Text(
                          item.titleKey.tr, // ترجمة حسب لغة الجهاز
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          item.descKey.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.grey.shade300,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Dots Indicator
            Obx(
              () => DotsIndicator(
                currentIndex: onboardingController.currentIndex,
                count: onboardingController.items.length,
              ),
            ),
            SizedBox(height: 30.h),

            // Navigation Buttons
            Obx(() {
              final index = onboardingController.currentIndex.value;
              final lastIndex = onboardingController.items.length - 1;
              if (index == lastIndex) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SingleButton(
                      text: 'Back',
                      color: Colors.grey,
                      onPressed: onboardingController.onBack,
                    ),
                    SizedBox(width: 50.w),
                    SingleButton(
                      text: 'Start',
                      onPressed: onboardingController.startApp,
                      color: Colors.amber,
                    ),
                  ],
                );
              }
              return SingleButton(
                text: index == 0 ? 'Next' : 'Continue',
                onPressed: () {}, //onboardingController.onPageChanged,
                color: Colors.amber,
              );
            }),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
