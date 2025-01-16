import 'package:animai/core/constants/colors.dart';
import 'package:animai/core/constants/text_styles.dart';
import 'package:animai/src/features/navigation/domain/models/navigation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

/// Individual navigation item with accessibility support
class NavItem extends StatelessWidget {
  final int index;
  final NavigationItem item;
  final bool isSelected;
  final ValueChanged<int> onTap;
  final FocusNode focusNode;

  const NavItem({
    required this.index,
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.focusNode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Semantics(
        button: true,
        label: item.semanticLabel,
        selected: isSelected,
        child: Focus(
          focusNode: focusNode,
          child: GestureDetector(
            onTap: () => onTap(index),
            behavior: HitTestBehavior.opaque,
            child: ColoredBox(
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RepaintBoundary(
                      child: SvgPicture.asset(
                        isSelected ? item.selectedIcon : item.icon,
                        height: 22.h,
                        semanticsLabel: '',
                      ),
                    ),
                    Gap(4.h),
                    Text(
                      item.label,
                      style: getTextStyle(
                        color: isSelected ? AppColors.white : AppColors.platinum,
                        fp: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
