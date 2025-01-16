import 'package:animai/core/constants/text_styles.dart';
import 'package:animai/core/services/localization/language_extensions.dart';
import 'package:animai/src/common/widgets/model_card.dart';
import 'package:animai/src/features/home/presentation/widgets/home_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AIModelsGrid extends StatelessWidget {
  const AIModelsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final aiModels = HomeData.aiModels(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr.aiModels,
          style: textStyle13Grey(),
        ),
        Gap(14.h),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: ModelCard(
                model: aiModels[0],
                height: 220.w,
              ),
            ),
            Gap(8.w),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  ModelCard(
                    model: aiModels[1],
                    height: 106.w,
                  ),
                  Gap(8.h),
                  ModelCard(
                    model: aiModels[2],
                    height: 106.w,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
