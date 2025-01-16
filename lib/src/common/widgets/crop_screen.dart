import 'dart:typed_data';

import 'package:animai/core/constants/colors.dart';
import 'package:animai/core/constants/text_styles.dart';
import 'package:animai/core/constants/values.dart';
import 'package:animai/core/services/localization/language_extensions.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CropScreen extends StatefulWidget {
  final Uint8List imageData;
  final Function(Uint8List) onCropped;

  const CropScreen({
    required this.imageData,
    required this.onCropped,
  });

  @override
  _CropScreenState createState() => _CropScreenState();
}

class _CropScreenState extends State<CropScreen> {
  final _cropController = CropController();
  final bool _isCircleUi = false;
  final double _aspectRatio = 1.0;
  bool cropping = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: AppBar(
            backgroundColor: AppColors.jet,
            title: Text(
              context.tr.cropImage,
              style: getTextStyle(
                fp: FontSize.f16,
                color: AppColors.white,
                fw: FontWeight.w500,
              ),
            ),
            leading: IconButton(
              icon: RotatedBox(
                quarterTurns: context.isRTL ? 2 : 0,
                child: Icon(
                  CupertinoIcons.chevron_back,
                  size: 22.h,
                  color: AppColors.white,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: cropping
                    ? SizedBox(
                        height: 22.h,
                        width: 22.h,
                        child: const CircularProgressIndicator(
                          color: AppColors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Icon(
                        Icons.check,
                        size: 22.h,
                        color: AppColors.white,
                      ),
                onPressed: _cropImage,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Crop(
              controller: _cropController,
              image: widget.imageData,
              aspectRatio: _aspectRatio,
              progressIndicator: const CircularProgressIndicator(
                color: AppColors.white,
              ),
              withCircleUi: _isCircleUi,
              cornerDotBuilder: (size, edgeAlignment) =>
                  const SizedBox.shrink(),
              interactive: true,
              fixCropRect: true,
              onStatusChanged: (s) {
                if (s == CropStatus.cropping) {
                  setState(() => cropping = true);
                }
              },
              onCropped: (croppedData) {
                widget.onCropped(
                  croppedData is CropSuccess
                      ? croppedData.croppedImage
                      : Uint8List(0),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _cropImage() {
    _cropController.crop();
  }
}
