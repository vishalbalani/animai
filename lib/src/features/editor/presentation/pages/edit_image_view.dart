import 'package:animai/core/constants/colors.dart';
import 'package:animai/core/constants/text_styles.dart';
import 'package:animai/core/constants/values.dart';
import 'package:animai/core/services/localization/language_extensions.dart';
import 'package:animai/src/common/widgets/gradient_button.dart';
import 'package:animai/src/features/editor/presentation/widgets/image_comparison_widget.dart';
import 'package:animai/src/features/editor/presentation/widgets/edit_image_header.dart';
import 'package:animai/src/features/editor/presentation/widgets/edit_image_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class EditImageView extends StatelessWidget {
  const EditImageView({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppPadding.horizontalPadding.w),
          child: Column(
            children: [
              Gap(16.h),
              EditImageHeader(imagePath: imagePath),
              Gap(24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.tr.original,
                    style: getTextStyle(
                      color: AppColors.gainsboro,
                    ),
                  ),
                  Text(
                    context.tr.aiGenerated,
                    style: getTextStyle(
                      color: AppColors.gainsboro,
                    ),
                  ),
                ],
              ),
              Gap(16.h),
              SizedBox(
                height: 364.h,
                child: ImageComparison(
                  originalImagePath: imagePath,
                ),
              ),
              Gap(16.h),
              const EditImageModels(),
              Gap(44.h),
              GradientButton(
                text: context.tr.generateVideo,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
