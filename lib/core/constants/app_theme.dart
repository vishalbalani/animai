import 'package:flutter/material.dart';
import 'package:animai/core/constants/colors.dart';
import 'package:animai/core/constants/typography.dart';

/// Application theme configuration
class AppTheme {
  const AppTheme._();

  /// Dark theme configuration
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,

        // Color Scheme
        colorScheme: _colorScheme,
        primaryColor: AppColors.sunflowerYellow,
        scaffoldBackgroundColor: AppColors.jet,

        // Typography
        fontFamily: AppTypography.inter,

        // Interaction States
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,

        // Text Selection
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.sunflowerYellow,
          selectionColor: AppColors.sunflowerYellow.withValues(alpha: 0.3),
          selectionHandleColor: AppColors.sunflowerYellow,
        ),
      );

  /// Color scheme configuration
  static const ColorScheme _colorScheme = ColorScheme.dark(
    primary: AppColors.sunflowerYellow,
    secondary: AppColors.neonPink,
    surface: AppColors.jet,
    error: Colors.redAccent,
    onSecondary: AppColors.white,
    onSurface: AppColors.cultured,
    onError: AppColors.white,
  );
}
