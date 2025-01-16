import 'package:animai/core/constants/assets/base_assets.dart';

/// Manages icon assets used throughout the app
class IconAssets extends BaseAssets {
  IconAssets() : super('assets/icon');

  // Navigation - Home
  String get homeSelected => path('home_selected.svg');
  String get home => path('home.svg');

  // Navigation - Models
  String get modelsSelected => path('models_selected.svg');
  String get models => path('models.svg');

  // Navigation - Profile
  String get profileSelected => path('profile_selected.svg');
  String get profile => path('profile.svg');

  // Navigation - Projects
  String get projectsSelected => path('projects_selected.svg');
  String get projects => path('projects.svg');

  // Crown Icons
  String get crown => path('crown.svg');
  String get crown1 => path('crown_1.svg');
  String get crown2 => path('crown_2.svg');

  // Action Icons
  String get add => path('add.svg');
  String get back => path('back.svg');
  String get share => path('share.svg');
  String get download => path('download.svg');
  String get cross => path('cross.svg');
  String get checkmark => path('checkmark.svg');

  // Feature Icons
  String get message => path('message.svg');
  String get flower => path('flower.svg');
  String get robot => path('robot.svg');
  String get idea => path('idea.svg');
  String get media => path('media.svg');

  // Profile Icons
  String get star => path('star.svg');
  String get globe => path('globe.svg');
  String get bell => path('bell.svg');
  String get share1 => path('share_1.svg');
  String get mobile => path('mobile.svg');
  String get shield => path('shield.svg');
  String get receipt => path('receipt.svg');
}
