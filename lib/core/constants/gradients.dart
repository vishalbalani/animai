// lib/core/constants/gradients.dart

import 'package:flutter/material.dart';
import 'package:animai/core/constants/colors.dart';

/// Manages gradient definitions throughout the application
/// Provides consistent gradient styles for various UI elements
class Gradients {
  // Private constructor to prevent instantiation
  Gradients._();

  /// Brand identity gradient used in splash screen and primary branding
  /// Yellow -> Orange -> Pink transition, diagonally
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.42, 0.88],
    colors: [
      Color(0xFFFFDB6F), // Brand Yellow
      Color(0xFFF6861F), // Brand Orange
      Color(0xFFDF237B), // Brand Pink
    ],
  );

  /// Content overlay gradient for subscription cards
  /// Creates fade effect at top and bottom edges
  static const LinearGradient subscriptionOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.04, 0.4, 0.98],
    colors: [
      Color(0xFF000000), // Solid black fade at top
      AppColors.transparent, // Clear middle section
      Color(0xFF000000), // Solid black fade at bottom
    ],
  );

  /// Rainbow spectrum gradient for circular buttons
  /// Full brand color spectrum in continuous flow
  static const LinearGradient circularRainbow = LinearGradient(
    colors: [
      Color(0xFFFFDB6F), // Brand Yellow
      Color(0xFFF6861F), // Brand Orange
      Color(0xFFDF237B), // Brand Pink
      Color(0xFF7C4199), // Brand Purple
      Color(0xFF565EAA), // Brand Blue
    ],
  );

  /// Rainbow spectrum gradient for rectangular elements
  /// Same colors as circular but with diagonal flow
  static const LinearGradient rectangularRainbow = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFDB6F), // Brand Yellow
      Color(0xFFF6861F), // Brand Orange
      Color(0xFFDF237B), // Brand Pink
      Color(0xFF7C4199), // Brand Purple
      Color(0xFF565EAA), // Brand Blue
    ],
  );

  /// Overlay gradient for AI model cards
  /// Creates smooth fade effect for content visibility
  static const LinearGradient aiModelOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.32, 0.74, 0.95],
    colors: [
      Color(0xFF0C0C0C), // Jet black fade at top
      AppColors.transparent, // Clear upper middle
      AppColors.transparent, // Clear lower middle
      Color(0xFF0C0C0C), // Jet black fade at bottom
    ],
  );
}
