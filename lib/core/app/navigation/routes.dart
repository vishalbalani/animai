// lib/core/navigation/routes.dart

import 'package:animai/core/app/navigation/route_names.dart';
import 'package:animai/core/app/navigation/route_params.dart';
import 'package:flutter/material.dart';

// Feature imports
import 'package:animai/src/features/editor/presentation/pages/edit_image_view.dart';
import 'package:animai/src/features/splash/presentation/pages/splash_view.dart';
import 'package:animai/src/features/subscription/presentation/pages/subscription_plans_view.dart';
import 'package:animai/src/features/subscription/presentation/pages/subscription_purchase_view.dart';
import 'package:animai/src/features/navigation/presentation/pages/app_shell.dart';

/// Maps route names to their respective screen builders.
/// Centralizes all route definitions for easy maintenance.
final Map<String, WidgetBuilder> appRoutes = {
  AppRoutes.splash: (_) => const SplashView(),
  AppRoutes.subscriptionPlans: (_) => const SubscriptionPlansView(),
  AppRoutes.subscriptionPurchase: (_) => const SubscriptionPurchaseView(),
  AppRoutes.appShell: (_) => const AppShell(),

  // Routes with parameters
  AppRoutes.imageEditor: (context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is! ImageEditorParams) {
      throw const RouteException(
        'ImageEditorParams required for ImageEditor route',
      );
    }
    return EditImageView(imagePath: args.imagePath);
  },
};

/// Custom exception for route-related errors
class RouteException implements Exception {
  final String message;
  const RouteException(this.message);

  @override
  String toString() => 'RouteException: $message';
}
