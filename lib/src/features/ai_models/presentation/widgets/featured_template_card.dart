import 'package:animai/core/constants/colors.dart';
import 'package:animai/core/constants/gradients.dart';
import 'package:animai/core/constants/text_styles.dart';
import 'package:animai/core/constants/values.dart';
import 'package:animai/core/services/localization/language_extensions.dart';
import 'package:animai/src/common/widgets/build_gif_image.dart';
import 'package:animai/src/common/widgets/pro_tag.dart';
import 'package:animai/src/common/widgets/gradient_button.dart';
import 'package:animai/src/features/home/domain/models/ai_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeaturedTemplateCard extends StatelessWidget {
  final AIModel model;

  const FeaturedTemplateCard({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 408.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // GIF Background with optimized loading
          buildGifImage(model.path, borderRadius: 0),

          // Gradient Overlay
          Container(
            decoration: const BoxDecoration(
              gradient: Gradients.aiModelOverlay,
            ),
          ),

          // Content with animations
          _AnimatedContent(model: model),
        ],
      ),
    );
  }
}

class _AnimatedContent extends StatelessWidget {
  final AIModel model;

  const _AnimatedContent({required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.horizontalPadding.w,
        vertical: 16.h,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row with pro badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.tr.aiModels,
                style: getTextStyle(
                  fp: FontSize.f16,
                  fw: FontWeight.w600,
                ),
              ),
              const ProTag(showAnimation: false),
            ],
          ),
          // Bottom row with template info and button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                model.title!,
                style: getTextStyle(color: AppColors.white),
              ),
              SizedBox(
                width: 120.w,
                child: GradientButton(
                  onTap: () {},
                  height: 42,
                  fontSize: 12,
                  text: context.tr.useTemplate,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
