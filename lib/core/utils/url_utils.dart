import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/widgets.dart';
import 'package:animai/core/constants/app_secrets.dart';
import 'package:animai/core/utils/toast_utils.dart';

/// Utility class for handling URL and email launching
class UrlUtils {
  const UrlUtils._();

  /// Launches a URL in external browser
  static Future<void> launch(String url, BuildContext context) async {
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          _showErrorToast(url, context);
        }
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorToast(url, context);
      }
    }
  }

  /// Launches email client with support email
  static Future<void> launchEmail(BuildContext context) async {
    try {
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: AppSecrets.EMAIL_SUPPORT,
      );
      launchUrl(emailUri);
    } catch (e) {
      if (context.mounted) {
        _showErrorToast(AppSecrets.EMAIL_SUPPORT, context);
      }
    }
  }

  /// Shows error toast for failed launches
  static void _showErrorToast(String url, BuildContext context) {
    CustomToast.showToast(
      context: context,
      title: 'Error',
      description: 'Could not launch $url',
      type: ToastType.error,
    );
  }
}
