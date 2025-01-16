import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareUtils {
  ShareUtils._();

  static Future<void> shareImage(String? imagePath) async {
    try {
      if (imagePath == null) return;

      await Share.shareXFiles(
        [XFile(imagePath)],
        subject: 'Check out this AI-generated image!',
      );
    } catch (e) {
      debugPrint('Error sharing image: $e');
      // You can show a snackbar or dialog here
    }
  }
}
