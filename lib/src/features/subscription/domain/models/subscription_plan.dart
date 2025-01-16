/// Represents a subscription plan with its details
class SubscriptionPlan {
  final String id;
  final String price;
  final String period;
  final List<String> features;
  final bool isPopular;

  const SubscriptionPlan({
    required this.id,
    required this.price,
    required this.period,
    required this.features,
    this.isPopular = false,
  });
}
