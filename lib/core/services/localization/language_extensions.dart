import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension Translate on BuildContext {
  AppLocalizations get tr => AppLocalizations.of(this)!;

  // Add convenience getter for checking RTL
  bool get isRTL => Directionality.of(this) == TextDirection.rtl;

  // Add current locale getter
Locale get currentLocale => Localizations.localeOf(this);
}
