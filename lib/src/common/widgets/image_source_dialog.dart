// ignore_for_file: use_build_context_synchronously

import 'dart:ui';
import 'package:animai/core/constants/assets/assets.dart';
import 'package:animai/core/constants/colors.dart';
import 'package:animai/core/constants/text_styles.dart';
import 'package:animai/core/constants/values.dart';
import 'package:animai/core/services/localization/language_extensions.dart';
import 'package:animai/core/utils/permission_utils.dart';
import 'package:animai/core/utils/toast_utils.dart';
import 'package:animai/core/utils/image_picker_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceOption {
  final String title;
  final IconData icon;
  final ImageSource source;

  const ImageSourceOption({
    required this.title,
    required this.icon,
    required this.source,
  });
}

class ImageSourceDialog extends StatelessWidget {
  final Function(String) onImageSelected;
  final VoidCallback? onDismiss;

  const ImageSourceDialog({
    super.key,
    required this.onImageSelected,
    this.onDismiss,
  });

  Future<void> _handleImageSource(
    BuildContext context,
    ImageSource source,
  ) async {
    try {
      final bool hasPermission = source == ImageSource.camera
          ? await PermissionUtils.handleCameraPermission(context)
          : await PermissionUtils.handleGalleryPermission(context);

      if (!hasPermission) {
        return;
      }

      final imagePath = await ImagePickerUtils.pickAndCropImage(
        context,
        source,
      );

      if (!context.mounted) return;
      Navigator.of(context).pop();

      if (imagePath != null) {
        onImageSelected(imagePath);
      }
    } catch (e) {
      if (!context.mounted) return;
      CustomToast.showToast(
        context: context,
        title: source == ImageSource.camera ? "Camera error" : "Gallery error",
        type: ToastType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final options = [
      ImageSourceOption(
        title: context.tr.takePhoto,
        icon: Icons.camera_alt_outlined,
        source: ImageSource.camera,
      ),
      ImageSourceOption(
        title: context.tr.choosePhoto,
        icon: Icons.photo_library_outlined,
        source: ImageSource.gallery,
      ),
    ];

    return Stack(
      children: [
        _buildBlurredBackground(),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.horizontalPadding.w,
            vertical: 16.h,
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(context),
                Gap(10.h),
                _buildOptionsContainer(context, options),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBlurredBackground() {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: Image.asset(
          AppAssets.image.profileCurrentPlanBlur,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.tr.uploadImage,
          style: getTextStyle(
            fp: FontSize.f16,
            color: AppColors.white,
            fw: FontWeight.w500,
          ),
        ),
        IconButton(
          icon: Icon(Icons.close_rounded, size: 22.h),
          onPressed: () {
            Navigator.of(context).pop();
            onDismiss?.call();
          },
          color: AppColors.white,
        ),
      ],
    );
  }

  Widget _buildOptionsContainer(
    BuildContext context,
    List<ImageSourceOption> options,
  ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;

              return Column(
                children: [
                  if (index > 0)
                    Divider(
                      color: Colors.white.withValues(alpha: 0.3),
                      height: 1,
                    ),
                  _buildOptionTile(context, option),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionTile(BuildContext context, ImageSourceOption option) {
    return GestureDetector(
      onTap: () => _handleImageSource(context, option.source),
      child: ColoredBox(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 10.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                option.title,
                style: getTextStyle(
                  fp: FontSize.f16,
                  color: AppColors.white,
                  fw: FontWeight.w500,
                ),
              ),
              Icon(
                option.icon,
                color: AppColors.white,
                size: 22.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> showImageSourceDialog(
  BuildContext context, {
  required Function(String) onImageSelected,
  VoidCallback? onDismiss,
}) async {
  await showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
    ),
    backgroundColor: AppColors.jet,
    builder: (context) => ImageSourceDialog(
      onImageSelected: onImageSelected,
      onDismiss: onDismiss,
    ),
  );
}
