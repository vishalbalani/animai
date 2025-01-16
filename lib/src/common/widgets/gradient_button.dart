import 'package:animai/core/constants/values.dart';
import 'package:flutter/material.dart';
import 'package:animai/core/constants/colors.dart';
import 'package:animai/core/constants/typography.dart';
import 'package:animai/core/constants/gradients.dart';
import 'package:animai/core/constants/text_styles.dart';
import 'package:animai/core/utils/size_utils.dart';

/// A reusable gradient button with loading state, animations, and accessibility support.
/// This button is optimized for performance and follows platform-specific guidelines.
class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.text,
    required this.onTap,
    this.fontSize = FontSize.f16,
    this.height = 56,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback onTap;
  final double fontSize;
  final double height;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    // Use Material for better ink effects and accessibility
    return Material(
      color: Colors.transparent,
      child: Semantics(
        button: true,
        enabled: !isLoading,
        label: text,
        child: InkWell(
          onTap: isLoading ? null : onTap,
          borderRadius: BorderRadius.circular(999),
          // Customize splash effect based on platform
          splashColor: Theme.of(context).platform == TargetPlatform.iOS
              ? Colors.black12
              : Colors.white24,
          child: Container(
            height: height.responsiveHeight,
            decoration: BoxDecoration(
              gradient: Gradients.circularRainbow,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: AppColors.electricOrange),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: isLoading
                  ? const Center(
                      child: RepaintBoundary(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.white,
                            // Optimize animation performance
                            semanticsLabel: 'Loading',
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        text,
                        style: getTextStyle(
                          fp: fontSize,
                          ff: AppTypography.neueMachina,
                          color: AppColors.white,
                        ),
                        // Improve text rendering performance
                        textAlign: TextAlign.center,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
