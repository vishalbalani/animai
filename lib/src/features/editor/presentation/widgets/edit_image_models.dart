import 'package:animai/core/constants/text_styles.dart';
import 'package:animai/core/services/localization/language_extensions.dart';
import 'package:animai/src/features/editor/presentation/providers/editor_providers.dart';
import 'package:animai/src/features/editor/presentation/widgets/animated_model_card.dart';
import 'package:animai/src/features/editor/presentation/widgets/edit_image_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class EditImageModels extends ConsumerWidget {
  const EditImageModels({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedModelIndexProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr.models,
          style: textStyle13Grey(),
        ),
        Gap(14.h),
        SizedBox(
          height: 80.w,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: EditImageData.models.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: AnimatedModelCard(
                model: EditImageData.models[index],
                isSelected: selectedIndex == index,
                onTap: () {
                  ref.read(selectedModelIndexProvider.notifier).state = index;
                  HapticFeedback.selectionClick();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
