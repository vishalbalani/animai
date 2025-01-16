import 'package:animai/core/constants/assets/assets.dart';
import 'package:animai/core/constants/gradients.dart';
import 'package:animai/core/services/localization/language_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Center action button with accessibility support
class AddButton extends StatelessWidget {
  final VoidCallback onTap;
  final FocusNode focusNode;

  const AddButton({
    required this.onTap,
    required this.focusNode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: context.tr.addNewProject,
      child: Focus(
        focusNode: focusNode,
        child: GestureDetector(
          onTap: () {
            HapticFeedback.mediumImpact();
            onTap();
          },
          behavior: HitTestBehavior.opaque,
          child: ColoredBox(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RepaintBoundary(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        gradient: Gradients.rectangularRainbow,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: SvgPicture.asset(
                        AppAssets.icon.add,
                        height: 20.h,
                        excludeFromSemantics : true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
