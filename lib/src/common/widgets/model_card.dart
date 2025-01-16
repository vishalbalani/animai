import 'dart:ui';
import 'package:animai/core/constants/colors.dart';
import 'package:animai/core/constants/text_styles.dart';
import 'package:animai/core/utils/shimmer_utils.dart';
import 'package:animai/src/features/home/domain/models/ai_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ModelCard extends StatelessWidget {
  final AIModel model;
  final double? height;
  final double? width;
  final VoidCallback? onTap;
  final double? borderRadius;

  const ModelCard({
    super.key,
    required this.model,
    this.height,
    this.width,
    this.onTap,
    this.borderRadius,
  });

  Widget _buildErrorWidget(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      padding: EdgeInsets.all(12.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported_rounded,
            color: Colors.grey[400],
            size: 32.w,
          ),
          SizedBox(height: 8.h),
          Text(
            'Image not available',
            textAlign: TextAlign.center,
            style: getTextStyle(
              fp: 12,
              color: Colors.grey[600]!,
              fw: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              model.path,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  _buildErrorWidget(context),
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) return child;
                return frame == null
                    ? skeletonLoadingOnGif(borderRadius ?? 12)
                    : child;
              },
            ),
            if (model.title != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 2.0,
                      sigmaY: 2.0,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                      ),
                      child: Text(
                        model.title!,
                        style: getTextStyle(
                          fp: 11,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
