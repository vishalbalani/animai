import 'package:flutter/material.dart';

/// Application color palette configuration
/// Defines semantic color usage and provides color manipulation utilities
class AppColors {
  AppColors._();

  // Primary Brand Colors
  static const Color electricOrange =
      Color(0xFFF6861F); // Primary brand color - Used for CTAs, highlights
  static const Color neonPink =
      Color(0xFFDF237B); // Secondary brand color - Used for accents, badges
  static const Color sunflowerYellow =
      Color(0xFFFFDB6F); // Tertiary brand color - Used for premium features

  // Base Colors
  static const Color white = Color(0xFFFFFFFF); // Default light surfaces
  static const Color black = Color(0xFF000000); // Maximum contrast
  static const Color transparent = Colors.transparent; // Used for overlays

  // Text Colors
  static const Color richBlack =
      Color(0xff0C0C0C); // Primary text - Headings, important content
  static const Color platinum =
      Color(0xffB6B6B6); // Secondary text - Subtitles, captions
  static const Color charcoal =
      Color(0xff282828); // Tertiary text - Body content
  static const Color gainsboro = Color(0xffDADADA); // Disabled text
  static const Color quickSilver = Color(0xff919191); // Placeholder text
  static const Color cultured = Color(0xffF6F6F6); // Text on dark backgrounds

  // UI Colors
  static const Color gunmetal = Color(0xFF6D6D6D); // Borders, dividers
  static const Color jet = Color(0xFF0C0C0C); // Dark mode background

  /// Generates color variations for consistent shading
  /// Used for hover states, pressed states, and disabled states
  /// [color] - Base color to modify
  /// [darker] - Direction of modification
  /// [value] - Intensity of modification (0.0 to 1.0)
  static Color getShade(Color color, {bool darker = false, double value = .1}) {
    assert(value >= 0 && value <= 1, 'shade values must be between 0 and 1');

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness(
      (darker ? (hsl.lightness - value) : (hsl.lightness + value))
          .clamp(0.0, 1.0),
    );

    return hslDark.toColor();
  }
}

/// Extension for generating Material color swatches
/// Useful for theming and consistent color variations
extension MaterialColorGenerator on Color {
  /// Creates a complete material color swatch from a single color
  /// Used for theme configuration and consistent component states
  MaterialColor toMaterialColor() {
    final colorShades = <int, Color>{
      50: AppColors.getShade(this, value: 0.5), // Super light - Background
      100: AppColors.getShade(this, value: 0.4), // Very light - Hover
      200: AppColors.getShade(this, value: 0.3), // Light - Selected
      300: AppColors.getShade(this, value: 0.2), // Semi light - Pressed
      400: AppColors.getShade(this), // Base light
      500: this, // Primary
      600: AppColors.getShade(this, darker: true), // Base dark
      700: AppColors.getShade(this, value: 0.15, darker: true), // Semi dark
      800: AppColors.getShade(this, value: 0.2, darker: true), // Dark
      900: AppColors.getShade(this, value: 0.25, darker: true), // Very dark
    };
    return MaterialColor(value, colorShades);
  }
}
