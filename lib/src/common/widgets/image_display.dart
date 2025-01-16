import 'dart:io';

import 'package:animai/core/constants/colors.dart';
import 'package:flutter/material.dart';

class ImageDisplayWidget extends StatelessWidget {
  final String imagePath;

  const ImageDisplayWidget({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.file(
        File(imagePath),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('Error loading image: $error');
          return const ColoredBox(
            color: AppColors.platinum,
            child: Icon(
              Icons.error_outline,
              color: AppColors.neonPink,
              size: 32,
            ),
          );
        },
      ),
    );
  }
}
