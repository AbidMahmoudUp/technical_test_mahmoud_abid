import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Type scale from Figma. Line heights are expressed as `lineHeight / fontSize`
/// with even leading, which matches how Figma places text in its line box.
abstract final class AppTextStyles {
  static const serif = 'Cormorant Garamond';
  static const sans = 'Suisse Intl';

  static const display = TextStyle(
    fontFamily: serif,
    fontWeight: FontWeight.w300,
    fontSize: 56,
    height: 52 / 56,
    leadingDistribution: TextLeadingDistribution.even,
    letterSpacing: 56 * -0.04,
    fontFeatures: [
      FontFeature.liningFigures(),
      FontFeature.proportionalFigures(),
    ],
    color: AppColors.textPrimary,
  );

  static const body = TextStyle(
    fontFamily: sans,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 24 / 16,
    leadingDistribution: TextLeadingDistribution.even,
    color: AppColors.textPrimary,
  );

  static const caption = TextStyle(
    fontFamily: sans,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 18 / 14,
    leadingDistribution: TextLeadingDistribution.even,
    color: AppColors.textPrimary,
  );
}
