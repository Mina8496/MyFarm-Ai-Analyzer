import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/Widget/feature_Item.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
        FeatureItem(text: "Ads_Free".tr),
        FeatureItem(text: "Unlimited_AI".tr),
        FeatureItem(text: "Unlimited_Pro".tr),
        FeatureItem(text: "plant_care".tr),
      ],
    );
  }
}
