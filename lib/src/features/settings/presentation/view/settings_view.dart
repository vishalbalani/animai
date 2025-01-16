import 'package:animai/core/constants/assets/assets.dart';
import 'package:animai/core/constants/values.dart';
import 'package:animai/src/common/animations/fade_slide_transition.dart';
import 'package:animai/src/features/settings/presentation/widgets/premium_plan_card.dart';
import 'package:animai/src/features/settings/presentation/widgets/setting_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Create staggered animations for each element
    _animations = List.generate(
      3,
      (index) => CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          index * 0.1,
          (index * 0.1) + 0.6,
          curve: Curves.easeOut,
        ),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding:
              EdgeInsets.symmetric(horizontal: AppPadding.horizontalPadding.w),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Gap(99.5.h),
              // Animated Logo
              FadeSlideTransition(
                animation: _animations[0],
                child: Hero(
                  tag: 'app_logo',
                  child: SvgPicture.asset(
                    AppAssets.svg.logo,
                    height: 64.h,
                  ),
                ),
              ),
              Gap(32.h),

              // Animated Premium Plan Card
              FadeSlideTransition(
                animation: _animations[1],
                child: const PremiumPlanCard(),
              ),
              Gap(32.h),

              // Animated Settings List
              FadeSlideTransition(
                animation: _animations[2],
                child: const SettingOptions(),
              ),
              Gap(120.h),
            ]),
          ),
        ),
      ],
    );
  }
}
