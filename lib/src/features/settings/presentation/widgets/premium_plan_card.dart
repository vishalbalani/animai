import 'package:animai/core/app/navigation/route_names.dart';
import 'package:animai/core/constants/assets/assets.dart';
import 'package:animai/core/constants/colors.dart';
import 'package:animai/core/constants/text_styles.dart';
import 'package:animai/core/services/localization/language_extensions.dart';
import 'package:animai/src/common/widgets/gradient_button.dart';
import 'package:animai/src/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class PremiumPlanCard extends StatelessWidget {
  const PremiumPlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.3)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
          children: [
            // Gradient Overlay with Frost Effect
            Positioned.fill(
              child: Image.asset(
                AppAssets.image.profileCurrentPlanBlur,
                fit: BoxFit.cover,
              ),
            ),

            // Main Content
            Padding(
              padding: EdgeInsets.all(24.r),
              child: Column(
                children: [
                  // Crown Icon
                  SvgPicture.asset(
                    AppAssets.icon.receipt,
                    height: 20.h,
                  ),
                  Gap(12.h),
                  // Plan Title
                  Text(
                    context.tr.myCurrentPlan,
                    style: getTextStyle(
                      color: AppColors.white,
                      fw: FontWeight.w500,
                    ),
                  ),
                  Gap(12.h),
                  // Price Row
                  RichText(
                    text: TextSpan(
                      style: getTextStyle(
                        color: AppColors.white,
                      ),
                      children: [
                        TextSpan(
                          text: '${context.tr.premium} ',
                        ),
                        TextSpan(
                          text: '\$9.99',
                          style: getTextStyle(
                            color: AppColors.white,
                            fp: 23,
                            fw: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: ' / ${context.tr.month}',
                        ),
                      ],
                    ),
                  ),
                  Gap(12.h),
                  // Unsubscribe Button
                  BlocConsumer<SubscriptionBloc, SubscriptionState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () {},
                        success: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.subscriptionPlans,
                            (route) => false,
                          );
                        },
                      );
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 46.w),
                        child: GradientButton(
                          text: context.tr.unsubscribe,
                          isLoading: state.maybeWhen(
                            orElse: () => false,
                            loading: () => true,
                          ),
                          height: 45,
                          onTap: () async {
                            context.read<SubscriptionBloc>().add(
                                  const SubscriptionEvent.cancelSubscription(),
                                );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
