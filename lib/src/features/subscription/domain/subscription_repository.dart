/// Repository interface for subscription-related operations
abstract class SubscriptionRepository {
  Future<void> purchaseSubscription(String planPrice);
  Future<void> cancelSubscription();
  Future<bool> checkSubscriptionStatus();
}
