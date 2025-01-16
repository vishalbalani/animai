import 'package:animai/core/constants/assets/assets.dart';
import 'package:animai/core/services/localization/language_extensions.dart';
import 'package:animai/src/features/home/domain/models/ai_model.dart';
import 'package:flutter/material.dart';

class AiModelsData {
  AiModelsData._();

  static List<AIModel> mainAiModels(BuildContext context) => [
        AIModel(
          path: AppAssets.gif.djHeadphones,
          title: context.tr.theJoyLooper,
          isGif: true,
        ),
      ];

  static List<AIModel> otherAiModels = [
    AIModel(path: AppAssets.gif.forYouCollection[0], isGif: true),
    AIModel(path: AppAssets.gif.forYouCollection[1], isGif: true),
    AIModel(path: AppAssets.gif.forYouCollection[2], isGif: true),
    AIModel(path: AppAssets.gif.forYouCollection[3], isGif: true),
    AIModel(path: AppAssets.gif.spaceExplorer, isGif: true),
    AIModel(path: AppAssets.gif.fireEffect, isGif: true),
  ];
}
