/// Base class for asset path management
abstract class BaseAssets {
  final String basePath;

  const BaseAssets(this.basePath);

  /// Builds a complete asset path
  String path(String assetName) => '$basePath/$assetName';
}
