import 'package:animai/core/constants/assets/assets.dart';
import 'package:animai/core/constants/gradients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

/// Widget that renders the splash screen background with gradient and SVG images
class SplashBackground extends StatelessWidget {
  const SplashBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: Gradients.brandGradient,
      ),
      child: Stack(
        children: [
          _buildTopRightDecoration(),
          _buildBottomLeftDecoration(),
        ],
      ),
    );
  }

  Widget _buildTopRightDecoration() {
    return Positioned(
      top: 0,
      right: 0,
      child: Opacity(
        opacity: 0.12,
        child: SvgPicture.asset(AppAssets.svg.splashTopRight),
      ),
    );
  }

  Widget _buildBottomLeftDecoration() {
    return Positioned(
      bottom: 0,
      child: Opacity(
        opacity: 0.12,
        child: SvgPicture.asset(
          AppAssets.svg.splashBottomLeft,
          width: 360.w,
        ),
      ),
    );
  }
}
