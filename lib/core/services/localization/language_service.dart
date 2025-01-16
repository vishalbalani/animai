import 'dart:ui';

import 'package:animai/core/app/di/di.dart';
import 'package:animai/core/services/local_storage/shared_pref.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageService extends StateNotifier<Locale> {
  final SharedPref _sharedPref;
  static const _defaultLocale = Locale('en');

  LanguageService(this._sharedPref) : super(_defaultLocale) {
    _initLanguage();
  }

  Future<void> _initLanguage() async {
    final savedLanguage = await _sharedPref.readSharedPrefData<String>(
      SharedPrefKey.SP_USER_LANGUAGE,
    );
    if (savedLanguage != null) {
      state = Locale(savedLanguage);
    }
  }

  Future<void> setLanguage(String languageCode) async {
    await _sharedPref.writeSharedPrefData(
      SharedPrefKey.SP_USER_LANGUAGE,
      languageCode,
    );
    state = Locale(languageCode);
  }

  static final provider = StateNotifierProvider<LanguageService, Locale>(
    (ref) => LanguageService(sl()),
  );
}
