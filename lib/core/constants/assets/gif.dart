import 'package:animai/core/constants/assets/base_assets.dart';

/// Manages GIF animation assets used throughout the app
class GifAssets extends BaseAssets {
  GifAssets() : super('assets/gif');

  // Templates Section
  String get cyberpunkPortrait => path('women_cyberpunk.gif');
  String get spaceExplorer => path('man_in_space.gif');
  String get djHeadphones => path('men_in_headphones.gif');
  String get fireEffect => path('fire.gif');

  // For You Gallery
  List<String> get forYouCollection => [
        path('for_you_1.gif'),
        path('for_you_2.gif'),
        path('for_you_3.gif'),
        path('for_you_4.gif'),
      ];
}
