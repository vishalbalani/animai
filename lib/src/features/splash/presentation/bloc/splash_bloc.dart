import 'package:animai/core/services/local_storage/shared_pref.dart';
import 'package:animai/src/features/splash/data/models/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Manages the business logic for the splash screen
class SplashBloc extends Cubit<SplashState> {
  final SharedPref _sharedPref;

  SplashBloc(this._sharedPref) : super(SplashState.initial);

  Future<void> checkUserSubscription() async {
    try {
      emit(SplashState.loading);

      final isPremium = await _sharedPref.readSharedPrefData<bool>(
        SharedPrefKey.SP_USER_PREMIUM_PLAN,
      );

      emit(
        isPremium == true
            ? SplashState.authenticated
            : SplashState.unauthenticated,
      );
    } catch (e) {
      emit(SplashState.error);
    }
  }
}
