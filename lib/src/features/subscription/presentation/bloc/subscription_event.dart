part of 'subscription_bloc.dart';

@freezed
class SubscriptionEvent with _$SubscriptionEvent {
  const factory SubscriptionEvent.started() = _Started;
  const factory SubscriptionEvent.purchaseSubscription(
    String planPrice,
  ) = _PurchaseSubscription;
  const factory SubscriptionEvent.cancelSubscription() = _CancelSubscription;
}
