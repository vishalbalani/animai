import 'package:animai/core/constants/text_styles.dart';
import 'package:animai/core/services/localization/language_extensions.dart';
import 'package:animai/src/common/widgets/model_card.dart';
import 'package:animai/src/features/home/presentation/widgets/home_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class GalleryGrid extends StatelessWidget {
  const GalleryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr.yourGallery,
          style: textStyle13Grey(),
        ),
        Gap(14.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 8.w,
          ),
          itemCount: HomeData.galleryImages.length,
          itemBuilder: (context, index) => ModelCard(
            model: HomeData.galleryImages[index],
          ),
        ),
      ],
    );
  }
}
