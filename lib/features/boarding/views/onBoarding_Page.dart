import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myfarm/features/plant_analysis/Presentation/Controller/onboarding_controller.dart';

class OnboardingPage extends GetView<OnboardingPageController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            fit: StackFit.expand,
            children: [
              PageView.builder(
                controller: controller.pageController,
                onPageChanged: (index) => controller.currentIndex.value = index,
                itemCount: controller.items.length,
                itemBuilder: (_, index) {
                  final item = controller.items[index];

                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(item.image, fit: BoxFit.cover),
                      Container(color: Colors.black.withOpacity(0.3)),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item.titleKey.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              item.descKey.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),

              /// Bottom Section
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Obx(() {
                  final index = controller.currentIndex.value;
                  final lastIndex = controller.items.length - 1;

                  if (index == lastIndex) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: controller.previousPage,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 28.w,
                              vertical: 14.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.arrow_back_ios,
                                  size: 18.sp,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  'Back'.tr,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 24.w),
                        GestureDetector(
                          onTap: controller.startApp,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 28.w,
                              vertical: 14.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Start'.tr,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18.sp,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return Center(
                    child: GestureDetector(
                      onTap: controller.nextPage,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 28.w,
                          vertical: 14.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              index == 0 ? 'Next'.tr : 'Continue'.tr,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18.sp,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        }),
      ),
    );
  }
}
