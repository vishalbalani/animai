import 'package:package_info_plus/package_info_plus.dart';

/// Utility class for managing app version information
class AppVersionUtil {
  AppVersionUtil._();

  /// Returns the semantic version (e.g., "1.0.0")
  static Future<String> getVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  /// Returns the build number (e.g., "42")
  static Future<String> getBuildNumber() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }

  /// Returns full version with build number (e.g., "1.0.0+42")
  static Future<String> getFullVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return '${packageInfo.version}+${packageInfo.buildNumber}';
  }
}
