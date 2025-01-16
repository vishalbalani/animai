/// Base class for type-safe route parameters
abstract class RouteParams {
  const RouteParams();
}

/// Parameters required for the image editor screen
class ImageEditorParams extends RouteParams {
  final String imagePath;
  
  const ImageEditorParams({required this.imagePath});
}
