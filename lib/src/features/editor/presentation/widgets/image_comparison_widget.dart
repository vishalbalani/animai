import 'dart:io';

import 'package:animai/core/constants/colors.dart';
import 'package:animai/src/features/editor/presentation/providers/editor_providers.dart';
import 'package:animai/src/features/editor/presentation/widgets/edit_image_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui' as ui;

class ImageComparison extends ConsumerWidget {
  final String originalImagePath;

  const ImageComparison({
    super.key,
    required this.originalImagePath,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dragPosition = ref.watch(sliderPositionProvider);
    final iconImage = ref.watch(iconImageProvider);
    final selectedIndex = ref.watch(selectedModelIndexProvider);
    final aiGeneratedImagePath =
        EditImageData.selectedModelsCorrespondingImages[selectedIndex];

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: LayoutBuilder(
        key: ValueKey(aiGeneratedImagePath),
        builder: (context, constraints) => Stack(
          children: [
            SizedBox.expand(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  _buildImage(
                    File(originalImagePath),
                    constraints,
                    isAsset: false,
                  ),
                  ClipPath(
                    clipper: _BeforeAfterClipper(dragPosition),
                    child: _buildImage(
                      aiGeneratedImagePath,
                      constraints,
                      isAsset: true,
                    ),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: _buildSlider(dragPosition, iconImage, ref, context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(
    dynamic source,
    BoxConstraints constraints, {
    required bool isAsset,
  }) {
    final image = isAsset
        ? Image.asset(
            source as String,
            fit: BoxFit.cover,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
          )
        : Image.file(
            source as File,
            fit: BoxFit.cover,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
          );

    return AnimatedOpacity(
      opacity: 1.0,
      duration: const Duration(milliseconds: 300),
      child: image,
    );
  }

  Widget _buildSlider(
    double position,
    AsyncValue<ui.Image> iconImage,
    WidgetRef ref,
    BuildContext context,
  ) {
    return GestureDetector(
      onHorizontalDragStart: (details) =>
          _handleDragStart(details, ref, context),
      onHorizontalDragUpdate: (details) =>
          _handleDragUpdate(details, ref, context),
      child: CustomPaint(
        painter: _SliderPainter(position, iconImage.valueOrNull),
      ),
    );
  }

  void _handleDragStart(
    DragStartDetails details,
    WidgetRef ref,
    BuildContext context,
  ) {
    final box = context.findRenderObject()! as RenderBox;
    final center = box.size.height / 2;
    final touchPoint = box.globalToLocal(details.globalPosition);
    final currentPos = ref.read(sliderPositionProvider);

    if ((touchPoint.dy - center).abs() <= 26 &&
        (touchPoint.dx - currentPos * box.size.width).abs() <= 26) {
      _handleDragUpdate(
        DragUpdateDetails(
          globalPosition: details.globalPosition,
          localPosition: touchPoint,
        ),
        ref,
        context,
      );
    }
  }

  void _handleDragUpdate(
    DragUpdateDetails details,
    WidgetRef ref,
    BuildContext context,
  ) {
    ref.read(sliderPositionProvider.notifier).state =
        (details.localPosition.dx / context.size!.width).clamp(0, 1);
  }
}

class _BeforeAfterClipper extends CustomClipper<Path> {
  final double position;

  _BeforeAfterClipper(this.position);

  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(size.width * position, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width * position, size.height)
      ..close();
  }

  @override
  bool shouldReclip(_BeforeAfterClipper oldClipper) =>
      position != oldClipper.position;
}

class _SliderPainter extends CustomPainter {
  final double position;
  final ui.Image? iconImage;

  _SliderPainter(this.position, this.iconImage);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final circlePaint = Paint()
      ..color = AppColors.neonPink
      ..style = PaintingStyle.fill;

    final x = size.width * position;

    // Draw vertical line
    canvas.drawLine(
      Offset(x, 0),
      Offset(x, size.height),
      paint,
    );

    // Draw pink circle
    canvas.drawCircle(
      Offset(x, size.height / 2),
      26,
      circlePaint,
    );

    // Draw white border
    canvas.drawCircle(
      Offset(x, size.height / 2),
      25,
      paint,
    );

    // Draw icon image
    if (iconImage != null) {
      final iconRect = Rect.fromCenter(
        center: Offset(x, size.height / 2),
        width: 24,
        height: 24,
      );
      canvas.drawImageRect(
        iconImage!,
        Rect.fromLTWH(
          0,
          0,
          iconImage!.width.toDouble(),
          iconImage!.height.toDouble(),
        ),
        iconRect,
        Paint()..filterQuality = FilterQuality.high,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SliderPainter oldDelegate) =>
      position != oldDelegate.position || iconImage != oldDelegate.iconImage;
}
