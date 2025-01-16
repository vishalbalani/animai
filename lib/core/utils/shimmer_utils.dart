import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:animai/core/constants/colors.dart';

/// Extension that adds shimmer loading effect to any widget
extension ShimmerExtensions on Widget {
  /// Wraps the widget with a shimmer animation effect
  ///
  /// Parameters:
  /// - [baseColor]: Starting color of the shimmer (defaults to grey)
  /// - [highlightColor]: End color of the shimmer (defaults to white)
  Widget shimmerEffect({
    Color? baseColor,
    Color? highlightColor,
  }) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? AppColors.quickSilver,
      highlightColor: highlightColor ?? AppColors.white,
      child: this,
    );
  }
}

/// Creates a skeleton loading animation for GIF placeholders
///
/// Parameters:
/// - [radius]: Border radius of the container in logical pixels
Widget skeletonLoadingOnGif(double radius) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[850]!,
    highlightColor: Colors.grey[700]!,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(radius.r),
      ),
    ),
  );
}
