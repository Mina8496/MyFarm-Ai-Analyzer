import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/ViewModel/subscription_planModel.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/Widget/features_Section.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/Widget/footer_section.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/Widget/plans_Row.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/Widget/subscribe_Button.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/controller/subscription_Controller.dart';

class BottomPanel extends StatelessWidget {
  final List<PlanViewModel> plans;

  const BottomPanel({super.key, required this.plans});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubscriptionController());

    return Container(
      padding: const EdgeInsets.only(top: 50),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            spreadRadius: 85,
            color: ColorPalette.kWhiteColor,
            blurRadius: 800,
            offset: Offset(-30, 90),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const FeaturesSection(),
            SizedBox(height: 50.h),

            PlansRow(plans: plans, controller: controller),

            SizedBox(height: 25.h),

            SubscribeButton(
              onTap: () {},
              text: "Unlock_Access".tr,
              linearGradient: const LinearGradient(
                colors: [
                  ColorPalette.kPrimaryColor,
                  ColorPalette.kkPrimaryGreen,
                ],
              ),
            ),
            SubscribeButton(
              onTap: () => Get.toNamed('/signup'),
              text: "free_trial".tr,
              color: Colors.grey,
            ),

            SizedBox(height: 10.h),

            const FooterSection(),
          ],
        ),
      ),
    );
  }
}
