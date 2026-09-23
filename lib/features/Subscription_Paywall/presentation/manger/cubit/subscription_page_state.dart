import 'package:myfarm/features/Subscription_Paywall/presentation/ViewModel/subscription_plan_model.dart';
import 'package:myfarm/features/payment/domain/entities/billing_data.dart';

abstract class SubscriptionState {}

class SubscriptionInitial extends SubscriptionState {
  final List<SubscriptionPlanViewModel> plans;
  final int selectedIndex;
  SubscriptionInitial({required this.plans, this.selectedIndex = 0});
}

class SubscriptionNavigateToPayment extends SubscriptionState {
  final SubscriptionPlanViewModel selectedPlan;
  final BillingData billingData;
  SubscriptionNavigateToPayment(this.selectedPlan, this.billingData);
}

class SubscriptionNavigateToLogin extends SubscriptionState {}