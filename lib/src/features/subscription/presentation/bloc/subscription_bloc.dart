import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animai/src/features/subscription/domain/subscription_repository.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

part 'subscription_bloc.freezed.dart';

/// BLoC for managing subscription state and business logic
class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscriptionRepository _repository;

  SubscriptionBloc(this._repository)
      : super(const SubscriptionState.initial()) {
    on<SubscriptionEvent>(_handleEvent);
  }

  Future<void> _handleEvent(
    SubscriptionEvent event,
    Emitter<SubscriptionState> emit,
  ) async {
    try {
      emit(const SubscriptionState.loading());

      if (event is _PurchaseSubscription) {
        await _repository.purchaseSubscription(event.planPrice);
      } else if (event is _CancelSubscription) {
        await _repository.cancelSubscription();
      }

      emit(const SubscriptionState.success());
    } catch (e) {
      emit(SubscriptionState.error(e.toString()));
    }
  }
}
