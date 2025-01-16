import 'package:animai/core/app/navigation/route_names.dart';
import 'package:animai/core/constants/assets/assets.dart';
import 'package:animai/core/constants/colors.dart';
import 'package:animai/core/constants/typography.dart';
import 'package:animai/core/constants/gradients.dart';
import 'package:animai/core/constants/text_styles.dart';
import 'package:animai/core/constants/values.dart';
import 'package:animai/core/services/localization/language_extensions.dart';
import 'package:animai/src/common/widgets/build_gif_image.dart';
import 'package:animai/src/common/widgets/gradient_button.dart';
import 'package:animai/src/features/subscription/presentation/widget/plan_pricing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SubscriptionPlansView extends StatelessWidget {
  const SubscriptionPlansView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Semantics(
        label: context.tr.subscriptionScreen,
        child: SizedBox(
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image Layer with accessibility hidden
              Semantics(
                excludeSemantics:
                    true, // Hide from accessibility as it's decorative
                child: buildGifImage(AppAssets.gif.cyberpunkPortrait, borderRadius: 0),
              ),

              // Gradient Overlay Layer (decorative)
              Semantics(
                excludeSemantics: true,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: Gradients.subscriptionOverlay,
                  ),
                ),
              ),

              // Content Layer
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.horizontalPadding,
                ),
                child: Column(
                  children: [
                    Gap(72.h),

                    // Logo with semantic label
                    Semantics(
                      label: context.tr.appLogo,
                      child: Hero(
                        tag: 'app_logo',
                        child: SvgPicture.asset(
                          AppAssets.svg.logo,
                          height: 80.h,
                        ),
                      ),
                    ),

                    const Spacer(),

                    // Subscription heading with proper heading semantics
                    MergeSemantics(
                      child: Column(
                        children: [
                          Text(
                            context.tr.chooseSubscription,
                            textAlign: TextAlign.center,
                            style: getTextStyle(
                              ff: AppTypography.neueMachina,
                              fp: 28,
                              fw: FontWeight.w800,
                              height: 1.1,
                            ),
                          ),
                          Gap(16.h),
                          Text(
                            context.tr.subscribeToPremiumAndGetAccess,
                            textAlign: TextAlign.center,
                            style: getTextStyle(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Gap(16.h),

                    // Plan pricing with semantic grouping
                    MergeSemantics(
                      child: PlanPricingWidget(
                        pricingPer: context.tr.month,
                        price: '\$1.99',
                      ),
                    ),

                    Gap(24.h),

                    // Action button with proper semantic action
                    Semantics(
                      button: true,
                      label: context.tr.continue7DaysFreeTrial,
                      child: GradientButton(
                        text: context.tr.continue7DaysFreeTrial,
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.subscriptionPurchase);
                        },
                      ),
                    ),

                    Gap(66.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
