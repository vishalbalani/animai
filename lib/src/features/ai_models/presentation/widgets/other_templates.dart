import 'package:animai/core/constants/text_styles.dart';
import 'package:animai/core/constants/values.dart';
import 'package:animai/core/services/localization/language_extensions.dart';
import 'package:animai/src/common/widgets/build_gif_image.dart';
import 'package:animai/src/features/home/domain/models/ai_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<Widget> otherTemplates(
  BuildContext context,
  List<AIModel> otherModels,
  AnimationController controller,
) {
  return [
    // Header
    SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(
          left: AppPadding.horizontalPadding.w,
          right: AppPadding.horizontalPadding.w,
          bottom: 14.h,
        ),
        child: Text(
          context.tr.otherTemplates,
          style: textStyle13Grey(),
        ),
      ),
    ),
    // Grid with staggered animations
    SliverPadding(
      padding: EdgeInsets.only(
        left: AppPadding.horizontalPadding.w,
        right: AppPadding.horizontalPadding.w,
        bottom: 58.h,
      ),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8.w,
          crossAxisSpacing: 8.w,
          childAspectRatio: 0.8,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final animation = Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: controller,
                curve: Interval(
                  0.4 + (index * 0.1),
                  1.0,
                  curve: Curves.easeOut,
                ),
              ),
            );

            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.2),
                  end: Offset.zero,
                ).animate(animation),
                child: TemplateCard(model: otherModels[index]),
              ),
            );
          },
          childCount: otherModels.length,
        ),
      ),
    ),
  ];
}

class TemplateCard extends StatelessWidget {
  final AIModel model;

  const TemplateCard({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: buildGifImage(model.path),
    );
  }
}
