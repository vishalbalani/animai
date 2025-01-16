import 'package:animai/core/constants/values.dart';
import 'package:animai/src/features/home/presentation/widgets/ai_models_grid.dart';
import 'package:animai/src/features/home/presentation/widgets/for_you_grid.dart';
import 'package:animai/src/features/home/presentation/widgets/gallery_grid.dart';
import 'package:animai/src/features/home/presentation/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:animai/src/common/animations/fade_slide_animation.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.horizontalPadding.w,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Gap(16.h),
                const HomeHeader(),
                Gap(24.h),
                const AIModelsGrid(),
                Gap(24.h),
                const FadeSlideAnimation(
                  offset: 40,
                  child: ForYouGrid(),
                ),
                Gap(24.h),
                const FadeSlideAnimation(
                  offset: 50,
                  child: GalleryGrid(),
                ),
                Gap(24.h),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
