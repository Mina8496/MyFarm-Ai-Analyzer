import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/ViewModel/subscription_planModel.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/Widget/plan_Card.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/controller/subscription_Controller.dart';

class PlansRow extends StatelessWidget {
  final List<PlanViewModel> plans;
  final SubscriptionController controller;

  const PlansRow({super.key, required this.plans, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: plans
            .asMap()
            .entries
            .map(
              (e) => Expanded(
                child: GestureDetector(
                  onTap: () => controller.selectPlan(e.key),
                  child: PlanCard(
                    isSelected: controller.selectedIndex.value == e.key,
                    plan: e.value,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
