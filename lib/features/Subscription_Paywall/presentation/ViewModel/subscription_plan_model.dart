class SubscriptionPlanViewModel {
  final String title;
  final String price;
  final String duration;

  SubscriptionPlanViewModel({
    required this.title,
    required this.price,
    required this.duration,
  });
}

extension PlanMapper on SubscriptionPlanViewModel {
  SubscriptionPlanViewModel toViewModel() {
    return SubscriptionPlanViewModel(
      title: title,
      price: price,
      duration: duration,
    );
  }
}
