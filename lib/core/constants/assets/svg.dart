import 'package:animai/core/constants/assets/base_assets.dart';

/// Manages SVG vector assets used throughout the app
class SvgAssets extends BaseAssets {
  SvgAssets() : super('assets/svg');

  // Branding
  String get logo => path('logo.svg');

  // Splash Screen
  String get splashTopRight => path('splash_top_right.svg');
  String get splashBottomLeft => path('splash_bottom_left.svg');

  // UI Elements
  String get dullYellowTick => path('dull_yellow_tick.svg');
}
