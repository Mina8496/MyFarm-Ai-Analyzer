import 'package:flutter/material.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/ViewModel/subscription_planModel.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/Widget/plan_Card.dart';

class PlansRow extends StatelessWidget {
  final List<SubscriptionPlanViewModel> plans;
  final int selectedIndex;
  final void Function(int) onPlanSelected;

  const PlansRow({
    super.key,
    required this.plans,
    required this.selectedIndex,
    required this.onPlanSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: plans
          .asMap()
          .entries
          .map(
            (e) => Expanded(
              child: GestureDetector(
                onTap: () => onPlanSelected(e.key),
                child: PlanCard(
                  isSelected: selectedIndex == e.key,
                  plan: e.value,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
