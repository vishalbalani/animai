import 'package:animai/core/app/navigation/app_router.dart';
import 'package:animai/core/app/navigation/route_names.dart';
import 'package:animai/core/services/localization/language_service.dart';
import 'package:animai/core/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// MyApp is the root widget of the AnimAI application.
/// Implements a singleton pattern for consistent app configuration and state.
class MyApp extends ConsumerWidget {
  // Private constructor for singleton implementation
  const MyApp._();

  // Single instance accessible throughout the app
  static const MyApp instance = MyApp._();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch for locale changes through the language service
    final locale = ref.watch(LanguageService.provider);

    return ScreenUtilInit(
      // Design size matches the base Figma layout dimensions
      designSize: const Size(360, 800),
      minTextAdapt: true,
      builder: (_, child) => MaterialApp(
        // Localization configuration
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,

        // App configuration
        title: "Anim AI",
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,

        // Routing configuration
        onGenerateRoute: generateRoute,
        initialRoute: AppRoutes.splash,
      ),
    );
  }
}
