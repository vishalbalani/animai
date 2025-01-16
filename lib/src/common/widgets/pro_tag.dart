import 'package:animai/core/constants/assets/assets.dart';
import 'package:animai/core/constants/colors.dart';
import 'package:animai/core/constants/text_styles.dart';
import 'package:animai/core/services/localization/language_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

/// A premium badge widget displaying 'PRO' status with accessibility support
/// and smooth animations. Used to indicate premium features and content.
class ProTag extends StatelessWidget {
  const ProTag({
    super.key,
    this.onTap,
    this.showAnimation = true,
  });

  /// Optional callback when the tag is tapped
  final VoidCallback? onTap;

  /// Whether to show the hero animation
  final bool showAnimation;

  // Define constant dimensions
  static const double _horizontalPadding = 8;
  static const double _verticalPadding = 2;
  static const double _borderRadius = 16;
  static const double _iconSize = 22;
  static const double _iconGap = 3;

  @override
  Widget build(BuildContext context) {
    final Widget content = MergeSemantics(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.sunflowerYellow,
          borderRadius: BorderRadius.circular(_borderRadius.r),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: _horizontalPadding.w,
          vertical: _verticalPadding.h,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Semantics(
              excludeSemantics: true, // Decorative crown icon
              child: RepaintBoundary(
                child: SvgPicture.asset(
                  AppAssets.icon.crown1,
                  height: _iconSize.h,
                  colorFilter: const ColorFilter.mode(
                    AppColors.charcoal,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            Gap(_iconGap.w),
            Text(
              context.tr.pro,
              style: getTextStyle(
                color: AppColors.charcoal,
              ),
            ),
          ],
        ),
      ),
    );

    // Add tap handling if callback provided
    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_borderRadius.r),
        child: content,
      );
    }

    return Semantics(
      excludeSemantics: true,
      child: content,
    );
  }
}
