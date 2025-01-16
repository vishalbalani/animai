// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:animai/src/common/widgets/crop_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ImagePickerUtils {
  ImagePickerUtils._();

  static Future<String?> pickAndCropImage(
    BuildContext context,
    ImageSource source,
  ) async {
    try {
      final ImagePicker picker = ImagePicker();

      final XFile? pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (pickedFile == null) return null;

      // Read image bytes
      final imageBytes = await pickedFile.readAsBytes();

      // Navigate to crop screen
      final croppedImagePath = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CropScreen(
            imageData: imageBytes,
            onCropped: (croppedImage) async {
              final tempDir = await getTemporaryDirectory();
              final filePath = '${tempDir.path}/cropped_image.png';
              final file = await File(filePath).writeAsBytes(croppedImage);
              Navigator.of(context).pop(file.path); // Return the path
            },
          ),
        ),
      );
      return croppedImagePath as String;
    } catch (e) {
      return null;
    }
  }
}
