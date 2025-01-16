/// Utility class for showing customized toasts with accessibility support
/// and consistent styling across the application.
library;

import 'package:animai/core/constants/colors.dart';
import 'package:animai/core/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';

/// Defines different types of toast notifications
enum ToastType {
  success,
  error,
  info,
  warning;

  /// Maps enum to toastification type with proper null safety
  ToastificationType get toastType => switch (this) {
        success => ToastificationType.success,
        error => ToastificationType.error,
        info => ToastificationType.info,
        warning => ToastificationType.warning,
      };

  /// Gets semantic label for screen readers
  String get semanticLabel => switch (this) {
        success => 'Success notification',
        error => 'Error notification',
        info => 'Information notification',
        warning => 'Warning notification',
      };
}

/// Configuration for toast animations
class _ToastAnimationConfig {
  const _ToastAnimationConfig._();
  static const Duration duration = Duration(milliseconds: 300);
  static const Curve curve = Curves.easeInOut;

  static Widget buildAnimation(
    BuildContext context,
    Animation<double> animation,
    Alignment alignment,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: curve,
      ),
      child: child,
    );
  }
}

/// Custom toast implementation with accessibility and animation support
class CustomToast {
  const CustomToast._();

  /// Default configuration for toasts
  static const _defaultDuration = Duration(seconds: 4);
  static const _buttonToastDuration = Duration(seconds: 6);
  static const _maxWidth = 600.0;

  /// Shows a standard toast notification
  static void showToast({
    required BuildContext context,
    required String title,
    required ToastType type,
    String? description,
    VoidCallback? onTap,
    bool showProgressBar = false,
  }) {
    // Provide haptic feedback for important notifications
    if (type == ToastType.error || type == ToastType.warning) {
      HapticFeedback.mediumImpact();
    }

    toastification.show(
      context: context,
      type: type.toastType,
      style: ToastificationStyle.flat,
      autoCloseDuration: _defaultDuration,
      title: Semantics(
        label: '${type.semanticLabel}: $title',
        child: Text(
          title,
          style: getTextStyle(
            fp: 12,
            color: AppColors.white,
          ),
        ),
      ),
      description: description != null
          ? ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _maxWidth),
              child: Semantics(
                label: description,
                child: Text(
                  description,
                  style: getTextStyle(
                    fp: 12,
                    color: AppColors.white,
                  ),
                  maxLines: 99,
                ),
              ),
            )
          : null,
      alignment: Alignment.bottomCenter,
      direction: TextDirection.ltr,
      animationDuration: _ToastAnimationConfig.duration,
      animationBuilder: _ToastAnimationConfig.buildAnimation,
      showProgressBar: showProgressBar,
      closeOnClick: true,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: false,
      callbacks: ToastificationCallbacks(
        onTap: (toastItem) {
          HapticFeedback.selectionClick();
          onTap?.call();
        },
      ),
    );
  }

  /// Shows a toast with an action button
  static void showButtonToast({
    required BuildContext context,
    required String title,
    required String description,
    required ToastType type,
    VoidCallback? onCancelTap,
    bool showProgressBar = true,
    String buttonText = "Cancel Removal",
  }) {
    late ToastificationItem toastItem;

    // Provide haptic feedback for important notifications
    if (type == ToastType.error || type == ToastType.warning) {
      HapticFeedback.mediumImpact();
    }

    toastItem = toastification.show(
      context: context,
      type: type.toastType,
      style: ToastificationStyle.minimal,
      autoCloseDuration: _buttonToastDuration,
      title: Semantics(
        label: '${type.semanticLabel}: $title',
        child: Text(
          title,
          style: getTextStyle(
            fp: 12,
            color: AppColors.white,
          ),
        ),
      ),
      description: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _maxWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: getTextStyle(
                fp: 12,
                color: AppColors.white,
              ),
            ),
            Semantics(
              button: true,
              label: buttonText,
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  toastification.dismiss(toastItem);
                  onCancelTap?.call();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    buttonText,
                    style: getTextStyle(
                      fp: 12,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      alignment: Alignment.bottomCenter,
      direction: TextDirection.ltr,
      animationDuration: _ToastAnimationConfig.duration,
      animationBuilder: _ToastAnimationConfig.buildAnimation,
      showProgressBar: showProgressBar,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: false,
      backgroundColor: AppColors.jet,
    );
  }
}
