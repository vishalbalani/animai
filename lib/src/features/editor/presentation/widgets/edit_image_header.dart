import 'package:animai/core/constants/assets/assets.dart';
import 'package:animai/core/constants/colors.dart';
import 'package:animai/core/constants/gradients.dart';
import 'package:animai/core/constants/text_styles.dart';
import 'package:animai/core/constants/values.dart';
import 'package:animai/core/services/localization/language_extensions.dart';
import 'package:animai/core/utils/share_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class EditImageHeader extends StatelessWidget {
  const EditImageHeader({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Title in absolute center
        Positioned.fill(
          child: Center(
            child: Text(
              context.tr.editImage,
              style: getTextStyle(
                fp: FontSize.f16,
                fw: FontWeight.w600,
              ),
            ),
          ),
        ),

        // Back and action buttons in a row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Back button
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: CircleAvatar(
                radius: 20.r,
                backgroundColor: AppColors.charcoal,
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

            // Action buttons
            Row(
              children: [
                GestureDetector(
                  onTap: () => ShareUtils.shareImage(imagePath),
                  child: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: AppColors.charcoal,
                    child: SvgPicture.asset(
                      AppAssets.icon.share,
                      height: 18.h,
                      colorFilter: const ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                Gap(8.w),
                Container(
                  width: 20.r * 2,
                  height: 20.r * 2,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: Gradients.rectangularRainbow,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AppAssets.icon.download,
                      colorFilter: const ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                      height: 18.h,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
