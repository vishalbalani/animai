import 'package:animai/core/constants/gradients.dart';
import 'package:animai/src/common/widgets/model_card.dart';
import 'package:animai/src/features/home/domain/models/ai_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedModelCard extends StatelessWidget {
  final AIModel model;
  final bool isSelected;
  final VoidCallback onTap;

  const AnimatedModelCard({
    super.key,
    required this.model,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        gradient: isSelected ? Gradients.rectangularRainbow : null,
      ),
      child: ModelCard(
        model: model,
        height: 76.w,
        borderRadius: 4.r,
        width: 76.w,
        onTap: onTap,
      ),
    );
  }
}
