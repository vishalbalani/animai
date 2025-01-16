import 'package:animai/core/constants/assets/assets.dart';
import 'package:animai/core/constants/colors.dart';
import 'package:animai/core/constants/values.dart';
import 'package:animai/core/utils/size_utils.dart';
import 'package:animai/core/constants/text_styles.dart';
import 'package:animai/core/services/localization/language_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

/// Widget that displays the pricing information for a subscription plan
class PlanPricingWidget extends StatelessWidget {
  final String pricingPer;
  final String price;

  const PlanPricingWidget({
    super.key,
    required this.pricingPer,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${context.tr.premium} $price ${context.tr.per} $pricingPer',
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.sunflowerYellow,
        ),
        width: double.infinity,
        height: 60.responsiveHeight,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.horizontalPadding.w,
          ),
          child: Row(
            children: [
              Semantics(
                excludeSemantics: true, // Decorative icon
                child: SvgPicture.asset(
                  AppAssets.svg.dullYellowTick,
                  height: 26.h,
                ),
              ),
              Gap(10.w),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: getTextStyle(
                      color: AppColors.richBlack,
                    ),
                    children: [
                      TextSpan(
                        text: "${context.tr.premium} ",
                      ),
                      TextSpan(
                        text: price,
                        style: getTextStyle(
                          fp: 24,
                          fw: FontWeight.w700,
                          color: AppColors.richBlack,
                        ),
                      ),
                      TextSpan(
                        text: ' / $pricingPer',
                      ),
                    ],
                  ),
                ),
              ),
              Semantics(
                excludeSemantics: true, // Decorative icon
                child: SvgPicture.asset(
                  AppAssets.icon.crown,
                  height: 26.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
