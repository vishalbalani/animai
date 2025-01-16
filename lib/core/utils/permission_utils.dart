import 'dart:io';
import 'package:animai/core/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  PermissionUtils._();

  static Future<bool> handleNotificationPermission(BuildContext context) async {
    try {
      await Permission.storage.request();

      final status = await Permission.notification.status;
      if (status.isGranted) return true;

      final result = await Permission.notification.request();
      if (result.isGranted) return true;


      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> handleCameraPermission(BuildContext context) async {
    try {
      final status = await Permission.camera.status;
      if (status.isGranted) return true;

      final result = await Permission.camera.request();
      if (result.isGranted) return true;

      if (result.isPermanentlyDenied) {
        if (context.mounted) {
          _showPermissionToast(context, 'Camera');
        }
      }
      return false;
    } catch (e) {
      if (context.mounted) {
        _handleError(context, 'camera', e);
      }
      return false;
    }
  }

  static Future<bool> handleGalleryPermission(BuildContext context) async {
    try {
      if (Platform.isIOS) {
        return _handlePhotosPermission(context);
      }
      return true;
    } catch (e) {
      if (context.mounted) {
        _handleError(context, 'gallery', e);
      }
      return false;
    }
  }

  static Future<bool> _handlePhotosPermission(BuildContext context) async {
    try {
      final status = await Permission.photos.status;

      // Handle already granted permissions
      if (status.isGranted) return true;

      // Handle limited photos permission
      if (status.isLimited) {
        // You might want to show a dialog here explaining that limited access might affect functionality
        return true; // or handle limited access according to your app's needs
      }

      // Request permission if not yet determined
      if (status.isDenied) {
        final result = await Permission.photos.request();

        // Handle the result of permission request
        if (result.isGranted || result.isLimited) {
          return true;
        }

        if (result.isPermanentlyDenied) {
          if (context.mounted) {
            _showPermissionToast(context, 'Photos');
          }
          return false;
        }
      }

      // Handle permanent denial
      if (status.isPermanentlyDenied) {
        if (context.mounted) {
          _showPermissionToast(context, 'Photos');
        }
        return false;
      }

      return false;
    } catch (e) {
      if (context.mounted) {
        _handleError(context, 'photos', e);
      }
      return false;
    }
  }

  static void _showPermissionToast(
    BuildContext context,
    String permissionType,
  ) {
    final String title;
    final String description;

    switch (permissionType.toLowerCase()) {
      case 'camera':
        title = 'Camera Access Required';
        description =
            'Please enable camera access in your device settings to take photos.';
      case 'photos':
        title = 'Photo Access Required';
        description =
            'Please enable photo library access in your device settings to select images.';
      case 'storage':
        title = 'Storage Access Required';
        description =
            'Please enable storage access in your device settings to manage photos.';
      default:
        title = 'Permission Required';
        description =
            'Please enable necessary permissions in your device settings to continue.';
    }

    CustomToast.showButtonToast(
      context: context,
      title: title,
      description: description,
      type: ToastType.error,
      buttonText: 'Open Settings',
      onCancelTap: () async {
        await openAppSettings();
      },
    );
  }

  static void _handleError(BuildContext context, String type, dynamic error) {
    final String title;
    final String message;

    if (error is PlatformException) {
      switch (error.code) {
        case 'camera_access_denied':
          title = 'Camera Access Denied';
          message =
              'Unable to access camera. Please check your device settings and try again.';
        case 'photo_access_denied':
          title = 'Photo Access Denied';
          message =
              'Unable to access photos. Please check your device settings and try again.';
        default:
          title = 'Access Error';
          message = 'Unable to access ${type.toLowerCase()}. Please try again.';
      }
    } else {
      title = 'Something Went Wrong';
      message = 'Unable to complete the requested action. Please try again.';
    }

    CustomToast.showToast(
      context: context,
      title: title,
      description: message, // Added description for more context
      type: ToastType.error,
    );
  }
}
