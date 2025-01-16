import 'package:animai/core/constants/assets/assets.dart';
import 'package:animai/src/features/home/domain/models/ai_model.dart';

class EditImageData {
  EditImageData._();

  static List<AIModel> models = [
    AIModel(path: AppAssets.image.militaryMan),
    AIModel(path: AppAssets.gif.forYouCollection[1], isGif: true),
    AIModel(path: AppAssets.gif.forYouCollection[2], isGif: true),
    AIModel(path: AppAssets.gif.forYouCollection[3], isGif: true),
  ];

  static List<String> selectedModelsCorrespondingImages = [
    AppAssets.image.galleryImages[0],
    AppAssets.image.galleryImages[1],
    AppAssets.image.galleryImages[2],
    AppAssets.image.galleryImages[3],
  ];
}
