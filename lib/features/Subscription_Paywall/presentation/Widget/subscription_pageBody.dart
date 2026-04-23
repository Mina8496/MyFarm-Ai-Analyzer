import 'package:flutter/material.dart';
import 'package:myfarm/features/Subscription_Paywall/domin/useCase/GetPlans_UseCase.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/ViewModel/subscription_planModel.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/Widget/Video_header.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/Widget/bottom_panel.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/Widget/subscripion_header.dart';

class SubscriptionPageBody extends StatelessWidget {
  const SubscriptionPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final plans = GetPlansUseCase()();
    final planViewModels = plans.map((e) => e.toViewModel()).toList();

    return Stack(
      children: [
        ///  Background Video
        const VideoHeader(),

        /// Gradient Overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.7),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        ///  Content
        SafeArea(
          child: Stack(
            children: [
              /// (Text + Features)
              SubscripionHeader(),

              /// (BOTTOM PANEL)
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomPanel(plans: planViewModels),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
