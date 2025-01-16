/// Centralizes Links manages all external and internal URLs/URIs used in the application
class Links {
  // Private constructor prevents instantiation
  Links._();

  // External URLs
  static const String privacyPolicy = 'https://animai.com/privacy';
  static const String termsOfService = 'https://animai.com/terms';
  static const String helpCenter = 'https://animai.com/help';

  // Social Media Links
  static const String twitter = 'https://twitter.com/animai';
  static const String instagram = 'https://instagram.com/animai';
  static const String discord = 'https://discord.gg/animai';

  // Deep Links
  static const String deepLinkPrefix = 'animai://';
  static const String shareProjectDeepLink = '${deepLinkPrefix}project/';
}
