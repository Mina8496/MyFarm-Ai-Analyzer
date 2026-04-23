class SubscriptionPlan {
  final String title;
  final String price;
  final String duration;
  final bool isBestOffer;

  SubscriptionPlan({
    required this.title,
    required this.price,
    required this.duration,
    this.isBestOffer = false,
  });
}