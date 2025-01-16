import 'package:animai/core/services/local_storage/shared_pref.dart';
import 'package:animai/core/services/notifications/notification_service.dart';
import 'package:animai/src/features/subscription/domain/subscription_repository.dart';

// lib/src/features/subscription/data/repositories/subscription_repository_impl.dart
/// Implementation of the subscription repository
class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final SharedPref _sharedPref;
  final NotificationServices _notificationService;

  SubscriptionRepositoryImpl(this._sharedPref, this._notificationService);

  @override
  Future<void> purchaseSubscription(String planPrice) async {
    // TODO: Implement actual payment gateway integration
    await Future.delayed(const Duration(seconds: 2)); // Simulated delay
    await _sharedPref.writeSharedPrefData(
      SharedPrefKey.SP_USER_PREMIUM_PLAN,
      true,
    );
    _notificationService.showNotification(
      title: "Purchase Successful",
      body:
          "Thank you for your purchase of \$$planPrice. We appreciate your support!",
    );
  }

  @override
  Future<void> cancelSubscription() async {
    // TODO: Implement actual subscription cancellation logic
    await Future.delayed(const Duration(seconds: 2));
    await _sharedPref.writeSharedPrefData(
      SharedPrefKey.SP_USER_PREMIUM_PLAN,
      false,
    );
    _notificationService.showNotification(
      title: "We're Sad to See You Go",
      body: "Thank you for being with us. We hope to welcome you back soon!",
    );
  }

  @override
  Future<bool> checkSubscriptionStatus() async {
    return await _sharedPref.readSharedPrefData<bool>(
          SharedPrefKey.SP_USER_PREMIUM_PLAN,
        ) ??
        false;
  }
}
