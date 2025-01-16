import 'package:animai/core/constants/colors.dart';
import 'package:animai/core/constants/typography.dart';
import 'package:animai/core/constants/values.dart';
import 'package:animai/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

/// Creates a customized TextStyle with consistent defaults
///
/// Parameters:
/// - [fp] Font size in pixels (default: 13)
/// - [height] Line height (default: 1.2)
/// - [decoration] Text decoration (default: none)
/// - [color] Text color (default: cultured)
/// - [fw] Font weight (default: w400/regular)
/// - [ff] Font family (default: Inter)
/// - [fs] Font style (default: normal)
/// - [overflow] Text overflow behavior (default: visible)
///
/// Returns a TextStyle with responsive font sizing
TextStyle getTextStyle({
  double fp = FontSize.defaultFontSize,
  double height = 1.2,
  TextDecoration decoration = TextDecoration.none,
  Color color = AppColors.cultured,
  FontWeight fw = FontWeight.w400,
  String ff = AppTypography.inter,
  FontStyle fs = FontStyle.normal,
  TextOverflow overflow = TextOverflow.visible,
  double? letterSpacing,
}) {
  return TextStyle(
    fontSize: SizeUtils.responsiveFontSize(fp), // Responsive font size
    height: height, // Line height
    fontFamily: ff, // Font family
    color: color, // Text color
    fontStyle: fs, // Font style (normal/italic)
    overflow: overflow, // Overflow handling
    fontWeight: fw, // Font weight
    decoration: decoration, // Text decoration
    decorationColor: color, // Decoration color matches text
    letterSpacing: letterSpacing,
  );
}

TextStyle textStyle13Grey() {
  return getTextStyle(color: AppColors.platinum);
}
