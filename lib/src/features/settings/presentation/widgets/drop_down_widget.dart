import 'package:animai/core/constants/assets/assets.dart';
import 'package:animai/core/constants/colors.dart';
import 'package:animai/core/constants/text_styles.dart';
import 'package:animai/core/constants/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropdownItemsModel {
  final String id;
  final String value;
  DropdownItemsModel({required this.id, required this.value});
}

class DropdownContent extends StatelessWidget {
  const DropdownContent({
    required this.label,
    required this.items,
    required this.selectedItem,
    required this.selectedFromDropDown,
  });

  final String label;
  final List<DropdownItemsModel> items;
  final void Function(String?) selectedFromDropDown;
  final String selectedItem;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.transparent,
      child: Stack(
        children: [
          // Gradient Circle Background
          Image.asset(
            AppAssets.image.dropdownBlur,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Frosted Glass Content
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.jet.withValues(alpha: 0.05),
                border: Border.all(
                  color: AppColors.jet.withValues(alpha: 0.2),
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 22.h, bottom: 16.h),
                    child: Text(
                      label,
                      style: getTextStyle(
                        fp: FontSize.f16,
                        color: AppColors.white,
                        fw: FontWeight.w500,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.white.withValues(alpha: 0.3),
                    height: 1,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppPadding.horizontalPadding.w,
                        vertical: 8.h,
                      ),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 6.h,
                            horizontal: 6.w,
                          ),
                          child: SelectableTile(
                            text: items[index].value,
                            isSelected: items[index].id == selectedItem,
                            onTap: () {
                              selectedFromDropDown(items[index].id);
                              Navigator.of(context).pop();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectableTile extends StatelessWidget {
  const SelectableTile({
    super.key,
    required this.text,
    this.isSelected = false,
    required this.onTap,
    this.fp = 14,
    this.changeFontOnSelected = true,
  });

  final String text;
  final double fp;
  final bool isSelected;
  final VoidCallback onTap;
  final bool changeFontOnSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 12.w,
        ),
        decoration: BoxDecoration(
          color: AppColors.charcoal.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(7.r),
          border: Border.all(
            color: isSelected
                ? AppColors.sunflowerYellow
                : AppColors.white.withValues(alpha: 0.2),
            width: 1.2,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: AppColors.sunflowerYellow.withValues(alpha: 0.2),
                blurRadius: 8,
              ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: getTextStyle(
              fp: fp,
              color: isSelected ? AppColors.sunflowerYellow : AppColors.white,
              fw: isSelected
                  ? changeFontOnSelected
                      ? FontWeight.w700
                      : FontWeight.w600
                  : FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
