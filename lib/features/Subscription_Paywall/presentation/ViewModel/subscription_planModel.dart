import 'package:myfarm/features/Subscription_Paywall/domin/Entity/SubscriptionPlan_Entity.dart';

class PlanViewModel {
  final String title;
  final String price;
  final String duration;

  PlanViewModel({
    required this.title,
    required this.price,
    required this.duration,
  });
}

extension PlanMapper on SubscriptionPlan {
  PlanViewModel toViewModel() {
    return PlanViewModel(
      title: title,
      price: price,
      duration: duration,
    );
  }
}