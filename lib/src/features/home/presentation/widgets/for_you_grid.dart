import 'package:animai/core/constants/text_styles.dart';
import 'package:animai/core/services/localization/language_extensions.dart';
import 'package:animai/src/common/widgets/model_card.dart';
import 'package:animai/src/features/home/presentation/widgets/home_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ForYouGrid extends StatelessWidget {
  const ForYouGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        Gap(14.h),
        SizedBox(
          height: 105.w,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: HomeData.forYouStyles.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: ModelCard(
                model: HomeData.forYouStyles[index],
                height: 105.w,
                width: 76.w,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.tr.forYou,
          style: textStyle13Grey(),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            context.tr.viewAll,
            style: textStyle13Grey(),
          ),
        ),
      ],
    );
  }
}
