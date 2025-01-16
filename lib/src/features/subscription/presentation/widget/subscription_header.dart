import 'package:animai/core/constants/assets/assets.dart';
import 'package:animai/core/constants/colors.dart';
import 'package:animai/core/constants/text_styles.dart';
import 'package:animai/core/constants/values.dart';
import 'package:animai/core/services/localization/language_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Header widget for subscription screens with navigation controls
class SubscriptionHeader extends StatelessWidget {
  const SubscriptionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Title in absolute center
        Positioned.fill(
          child: Semantics(
            header: true,
            child: Center(
              child: Text(
                context.tr.subscription,
                style: getTextStyle(
                  fp: FontSize.f16,
                  fw: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),

        // Navigation buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Back button with focus node for keyboard navigation
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: CircleAvatar(
                radius: 20.r,
                backgroundColor: AppColors.charcoal,
                child: Focus(
                  child: Semantics(
                    button: true,
                    label: context.tr.back,
                    child: RotatedBox(
                      quarterTurns: context.isRTL ? 2 : 0,
                      child: SvgPicture.asset(
                        AppAssets.icon.back,
                        height: 18.h,
                        colorFilter: const ColorFilter.mode(
                          AppColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Close button
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: CircleAvatar(
                radius: 20.r,
                backgroundColor: AppColors.charcoal,
                child: Focus(
                  child: Semantics(
                    button: true,
                    label: context.tr.close,
                    child: SvgPicture.asset(
                      AppAssets.icon.cross,
                      height: 18.h,
                      colorFilter: const ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
