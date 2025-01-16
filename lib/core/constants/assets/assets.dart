import 'package:animai/core/constants/assets/gif.dart';
import 'package:animai/core/constants/assets/svg.dart';
import 'package:animai/core/constants/assets/image.dart';
import 'package:animai/core/constants/assets/icon.dart';
import 'package:animai/core/constants/assets/json.dart';

/// Central access point for all application assets
/// Provides typed access to different asset categories
class AppAssets {
  const AppAssets._();

  /// GIF animations and dynamic image assets
  static final gif = GifAssets();

  /// Vector graphics and icons
  static final svg = SvgAssets();

  /// Static images and photos
  static final image = ImageAssets();

  /// App icons and launcher icons
  static final icon = IconAssets();

  /// JSON data files and configurations
  static final json = JsonAssets();
}
