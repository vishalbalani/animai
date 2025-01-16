import 'package:animai/core/constants/assets/assets.dart';
import 'package:animai/core/constants/colors.dart';
import 'package:animai/core/constants/text_styles.dart';
import 'package:animai/core/constants/values.dart';
import 'package:animai/core/services/localization/language_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

/// A widget that displays detailed subscription information with a frosted glass effect
/// and accessibility support. Used in the subscription purchase flow to show premium
/// features and pricing information.
class DetailedPlanWidget extends StatelessWidget {
  const DetailedPlanWidget({super.key});

  // Define spacing constants
  static const double _verticalFeatureSpacing = 12;
  static const double _contentPadding = 24;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: context.tr.premiumPlanDetails,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
          children: [
            // Background blur effect using pre-rendered image
            Positioned.fill(
              child: Semantics(
                excludeSemantics: true, // Decorative background
                child: RepaintBoundary(
                  child: Image.asset(
                    AppAssets.image.detailedPlanTileBlur,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Main content container
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _contentPadding.w,
                vertical: _contentPadding.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildPremiumHeader(context),
                  Gap(48.h),
                  _buildFeaturesList(context),
                  Gap(24.h),
                  _buildDivider(),
                  Gap(24.h),
                  _buildPriceSection(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the premium header section with crown icon
  Widget _buildPremiumHeader(BuildContext context) {
    return Semantics(
      header: true,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: AppColors.richBlack,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Semantics(
                excludeSemantics: true, // Decorative icon
                child: SvgPicture.asset(
                  AppAssets.icon.crown2,
                  colorFilter: const ColorFilter.mode(
                    AppColors.sunflowerYellow,
                    BlendMode.srcIn,
                  ),
                  height: 24.h,
                ),
              ),
              Gap(10.w),
              Text(
                context.tr.premium,
                style: getTextStyle(
                  color: AppColors.sunflowerYellow,
                  fp: FontSize.f16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the features list section with accessibility support
  Widget _buildFeaturesList(BuildContext context) {
    final features = [
      (icon: AppAssets.icon.robot, text: context.tr.multipleAiModel),
      (icon: AppAssets.icon.flower, text: context.tr.imageEnhancement),
      (icon: AppAssets.icon.media, text: context.tr.videoGeneration),
      (icon: AppAssets.icon.idea, text: context.tr.uniqueAnimations),
      (icon: AppAssets.icon.message, text: context.tr.predefinedPrompts),
    ];

    return Semantics(
      label: context.tr.premiumFeatures,
      child: Column(
        children: features.map((feature) {
          return MergeSemantics(
            child: _buildFeatureItem(
              svgPath: feature.icon,
              text: feature.text,
            ),
          );
        }).toList(),
      ),
    );
  }

  /// Builds individual feature item with icon and text
  Widget _buildFeatureItem({
    required String svgPath,
    required String text,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: _verticalFeatureSpacing.h),
      child: Row(
        children: [
          Semantics(
            excludeSemantics: true, // Decorative feature icon
            child: SvgPicture.asset(
              svgPath,
              height: 20.h,
            ),
          ),
          Gap(AppPadding.horizontalPadding.w),
          Expanded(
            child: Text(
              text,
              style: getTextStyle(
                fp: FontSize.f16,
                color: AppColors.white,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          Semantics(
            excludeSemantics: true, // Decorative checkmark
            child: SvgPicture.asset(
              AppAssets.icon.checkmark,
              height: 20.h,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the divider between features and price
  Widget _buildDivider() {
    return Semantics(
      excludeSemantics: true, // Decorative divider
      child: const Opacity(
        opacity: 0.1,
        child: Divider(
          height: 1,
          color: AppColors.white,
        ),
      ),
    );
  }

  /// Builds the price section with trial information
  Widget _buildPriceSection(BuildContext context) {
    const price = "\$1.99";
    final period = context.tr.monthAfter7DaysTrial;

    return Semantics(
      label: '$price ${context.tr.per} $period',
      child: RichText(
        text: TextSpan(
          style: getTextStyle(
            color: AppColors.white,
          ),
          children: [
            TextSpan(
              text: price,
              style: getTextStyle(
                color: AppColors.white,
                fp: 19,
                fw: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: " / $period",
            ),
          ],
        ),
      ),
    );
  }
}
