import 'package:myfarm/features/Subscription_Paywall/presentation/ViewModel/subscription_plan_model.dart';

abstract class SubscriptionState {}

class SubscriptionInitial extends SubscriptionState {
  final List<SubscriptionPlanViewModel> plans;
  final int selectedIndex;
  SubscriptionInitial({required this.plans, this.selectedIndex = 0});
}

class SubscriptionNavigateToPayment extends SubscriptionState {
  final SubscriptionPlanViewModel selectedPlan;
  SubscriptionNavigateToPayment(this.selectedPlan);
}

class SubscriptionNavigateToLogin extends SubscriptionState {}
