import 'package:animai/core/constants/assets/assets.dart';
import 'package:animai/core/services/localization/language_extensions.dart';
import 'package:animai/src/features/home/domain/models/ai_model.dart';
import 'package:flutter/material.dart';

class HomeData {
  HomeData._();

  static List<AIModel> aiModels(BuildContext context) => [
        AIModel(path: AppAssets.image.militaryMan, title: context.tr.soldier),
        AIModel(
          path: AppAssets.image.smilingWoman,
          title: context.tr.smilingChild,
        ),
        AIModel(path: AppAssets.image.tattooMan, title: context.tr.tattooMan),
      ];

  static List<AIModel> forYouStyles = [
    AIModel(path: AppAssets.gif.forYouCollection[0], isGif: true),
    AIModel(path: AppAssets.gif.forYouCollection[1], isGif: true),
    AIModel(path: AppAssets.gif.forYouCollection[2], isGif: true),
    AIModel(path: AppAssets.gif.forYouCollection[3], isGif: true),
  ];

  static List<AIModel> galleryImages = [
    AIModel(path: AppAssets.image.galleryImages[0]),
    AIModel(path: AppAssets.image.galleryImages[1]),
    AIModel(path: AppAssets.image.galleryImages[2]),
    AIModel(path: AppAssets.image.galleryImages[3]),
    AIModel(path: AppAssets.image.galleryImages[4]),
    AIModel(path: AppAssets.image.galleryImages[5]),
    AIModel(path: AppAssets.image.galleryImages[6]),
    AIModel(path: AppAssets.image.galleryImages[7]),
  ];
}
