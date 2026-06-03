import 'package:myfarm/features/Subscription_Paywall/presentation/ViewModel/subscription_planModel.dart';

abstract class SubscriptionState {}

class SubscriptionInitial extends SubscriptionState {
  final List<PlanViewModel> plans;
  final int selectedIndex;
  SubscriptionInitial({required this.plans, this.selectedIndex = 0});
}

class SubscriptionNavigateToPayment extends SubscriptionState {}

class SubscriptionNavigateToLogin extends SubscriptionState {}