import 'package:animai/core/constants/assets/base_assets.dart';

/// Manages image assets used throughout the app
class ImageAssets extends BaseAssets {
  ImageAssets() : super('assets/img');

  // Home Banner Section
  String get militaryMan => path('military_man.png');
  String get smilingWoman => path('smiling_woman.png');
  String get tattooMan => path('tattoo_man.png');

  // Gallery Section
  List<String> get galleryImages => List.generate(
        8,
        (index) => path('gallery_${index + 1}.png'),
      );

  // Special Purpose Images
  String get gestures => path('gestures.png');
  String get detailedPlanTileBlur => path('detailed_plan_tile_blur.png');
  String get profileCurrentPlanBlur => path('profile_current_plan_blur.png');
  String get dropdownBlur => path('dropdown_blur.png');
}
