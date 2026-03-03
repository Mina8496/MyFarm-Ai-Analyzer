import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myfarm/core/widgets/app_Button.dart';
import 'package:myfarm/features/boarding/presentation/controllers/controller_onboarding.dart';
import 'package:myfarm/core/widgets/button_content.dart';
import 'package:myfarm/features/boarding/presentation/views/widgets/Page_View_OnBoarding.dart';

class OnboardingPageBody extends GetView<ControllerOnboardingPage> {
  const OnboardingPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        PageViewOnBoarding(controller: controller),

        /// Bottom Section
        Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            minimum: EdgeInsets.only(bottom: 30.h),
            child: Obx(() {
              if (controller.isLast) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButton(
                      onTap: controller.previousPage,
                      textApp: ButtonContent(
                        text: 'Back'.tr,
                        col: Colors.white,
                        icon: Icons.arrow_back_ios,
                        iconFirst: true,
                      ),
                    ),
                    SizedBox(width: 24.w),
                    AppButton(
                      onTap: controller.startApp,
                      textApp: ButtonContent(
                        text: 'Start'.tr,
                        col: Colors.white,
                        icon: Icons.arrow_forward_ios,
                      ),
                    ),
                  ],
                );
              }

              return AppButton(
                onTap: controller.nextPage,
                textApp: ButtonContent(
                  text: controller.nextTitle,
                  col: Colors.white,
                  icon: Icons.arrow_forward_ios,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
