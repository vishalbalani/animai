import 'package:animai/core/constants/assets/assets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui' as ui;

final sliderPositionProvider = StateProvider.autoDispose<double>((ref) => 0.5);

final selectedModelIndexProvider = StateProvider.autoDispose<int>((ref) => 0);

final iconImageProvider = FutureProvider.autoDispose<ui.Image>((ref) async {
  final data = await rootBundle.load(AppAssets.image.gestures);
  final codec = await ui.instantiateImageCodec(
    data.buffer.asUint8List(),
    targetWidth: 48,
    targetHeight: 48,
  );
  final frame = await codec.getNextFrame();
  return frame.image;
});
