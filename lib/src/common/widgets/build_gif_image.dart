import 'package:animai/core/utils/shimmer_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildGifImage(String path, {double borderRadius = 12}) {
  return Image.asset(
    path,
    fit: BoxFit.cover,
    width: double.infinity,
    height: double.infinity,
    errorBuilder: (context, error, stackTrace) => Container(
      color: Colors.grey[900],
      child: Center(
        child: Icon(
          Icons.image_not_supported_rounded,
          color: Colors.grey[700],
          size: 48.w,
        ),
      ),
    ),
    frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
      if (wasSynchronouslyLoaded) return child;
      return frame == null ? skeletonLoadingOnGif(borderRadius) : child;
    },
  );
}
