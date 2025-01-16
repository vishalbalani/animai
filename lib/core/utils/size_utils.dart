import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Utility class for managing responsive dimensions
/// Provides screen-relative sizing and constraints
class SizeUtils {
  const SizeUtils._();

  /// Device breakpoints for responsive design
  static const _Breakpoints breakpoints = _Breakpoints();

  /// Calculates width based on screen percentage
  ///
  /// Example:
  /// ```dart
  /// // Get 50% of screen width
  /// width = SizeUtils.widthPercent(50)
  /// ```
  static double widthPercent(double percentage) {
    assert(
      percentage >= 0 && percentage <= 100,
      'Percentage must be between 0 and 100',
    );
    return ScreenUtil().screenWidth * (percentage / 100);
  }

  /// Calculates height based on screen percentage
  ///
  /// Example:
  /// ```dart
  /// // Get 30% of screen height
  /// height = SizeUtils.heightPercent(30)
  /// ```
  static double heightPercent(double percentage) {
    assert(
      percentage >= 0 && percentage <= 100,
      'Percentage must be between 0 and 100',
    );
    return ScreenUtil().screenHeight * (percentage / 100);
  }

  /// Calculates responsive font size with tablet constraints
  ///
  /// [size] Base font size in logical pixels
  /// Returns scaled font size appropriate for device type
  static double responsiveFontSize(double size) {
    final screenWidth = ScreenUtil().screenWidth;
    final scaledSize = size.sp;

    if (scaledSize > size) {
      // Handle tablet scaling
      if (screenWidth > _Breakpoints.tablet) {
        return _constrainValue(
          value: scaledSize,
          max: size + _FontScaling.tabletMaxIncrease,
        );
      }
      return size; // Return original size for phones
    }
    return scaledSize; // Return scaled size if within bounds
  }

  /// Constrains a value between minimum and maximum bounds
  static double _constrainValue({
    required double value,
    double min = 0,
    required double max,
  }) {
    return value > max ? max : (value < min ? min : value);
  }
}

/// Device breakpoint definitions
class _Breakpoints {
  const _Breakpoints();

  /// Tablet breakpoint (700dp)
  static const double tablet = 700;

  /// Desktop breakpoint (1200dp)
  // static const double desktop = 1200;

  /// Large desktop breakpoint (1440dp)
  // static const double largeDesktop = 1440;
}

/// Font scaling configuration
class _FontScaling {
  const _FontScaling._();

  /// Maximum font size increase for tablets
  static const double tabletMaxIncrease = 7;
}

/// Extension for convenient screen-relative sizing
extension ResponsiveSizing on num {
  /// Returns constrained height
  /// Uses the larger of scaled height or original value
  double get responsiveHeight {
    final scaledHeight = h;
    return scaledHeight > this ? scaledHeight : toDouble();
  }

  /// Returns constrained width
  /// Uses the larger of scaled width or original value
  double get responsiveWidth {
    final scaledWidth = w;
    return scaledWidth > this ? scaledWidth : toDouble();
  }

  /// Shorthand for responsive font sizing
  double get responsive => SizeUtils.responsiveFontSize(toDouble());
}
