import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/Widget/features_Section.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/Widget/footer_section.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/Widget/plans_Row.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/Widget/showDialog_method.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/Widget/subscribe_Button.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/manger/cubit/subscription_page_cubit.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/manger/cubit/subscription_page_state.dart';

class BottomPanel extends StatelessWidget {
  const BottomPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubscriptionCubit, SubscriptionState>(
      listener: (context, state) {
        if (state is SubscriptionNavigateToPayment) {
          Get.toNamed('/PaymentScreen'); 
        }
        if (state is SubscriptionNavigateToLogin) {
          showDialogMethod(context);
        }
      },
      builder: (context, state) {
        if (state is! SubscriptionInitial) return const SizedBox.shrink();

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
                PlansRow(
                  plans: state.plans,
                  selectedIndex: state.selectedIndex,
                  onPlanSelected: (index) =>
                      context.read<SubscriptionCubit>().selectPlan(index),
                ),

                SizedBox(height: 25.h),

                SubscribeButton(
                  onTap: () =>
                      context.read<SubscriptionCubit>().onSubscribeTapped(),
                  text: "Unlock_Access".tr,
                  linearGradient: const LinearGradient(
                    colors: [
                      ColorPalette.kPrimaryColor,
                      ColorPalette.kkPrimaryGreen,
                    ],
                  ),
                ),
                SubscribeButton(
                  onTap: () => Navigator.pushNamed(context, '/home'),
                  text: "free_trial".tr,
                  color: Colors.grey,
                ),

                SizedBox(height: 10.h),
                const FooterSection(),
              ],
            ),
          ),
        );
      },
    );
  }  
}
