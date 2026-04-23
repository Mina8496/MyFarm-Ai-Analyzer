import 'package:flutter/material.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/Widget/subscription_pageBody.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.kPrimaryColor,
      body: SubscriptionPageBody(),
    );
  }
}
