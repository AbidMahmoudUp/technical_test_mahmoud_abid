import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Type scale from Figma. Line heights are expressed as `lineHeight / fontSize`
/// with even leading, which matches how Figma places text in its line box.
abstract final class AppTextStyles {
  static const serif = 'Cormorant Garamond';
  static const sans = 'Suisse Intl';
  static const _sansFallback = ['Inter'];

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

  static const title = TextStyle(
    fontFamily: sans,
    fontFamilyFallback: _sansFallback,
    fontWeight: FontWeight.w400,
    fontSize: 32,
    height: 36 / 32,
    leadingDistribution: TextLeadingDistribution.even,
    letterSpacing: 32 * -0.02,
    color: AppColors.textPrimary,
  );

  static const headline = TextStyle(
    fontFamily: sans,
    fontFamilyFallback: _sansFallback,
    fontWeight: FontWeight.w400,
    fontSize: 20,
    height: 24 / 20,
    leadingDistribution: TextLeadingDistribution.even,
    color: AppColors.textPrimary,
  );

  static const body = TextStyle(
    fontFamily: sans,
    fontFamilyFallback: _sansFallback,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 24 / 16,
    leadingDistribution: TextLeadingDistribution.even,
    color: AppColors.textPrimary,
  );

  static const bodySmall = TextStyle(
    fontFamily: sans,
    fontFamilyFallback: _sansFallback,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 20 / 14,
    leadingDistribution: TextLeadingDistribution.even,
    color: AppColors.textPrimary,
  );

  /// Chips and small section labels.
  static const label = TextStyle(
    fontFamily: sans,
    fontFamilyFallback: _sansFallback,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 18 / 14,
    leadingDistribution: TextLeadingDistribution.even,
    letterSpacing: 14 * -0.02,
    color: AppColors.textPrimary,
  );

  static const caption = TextStyle(
    fontFamily: sans,
    fontFamilyFallback: _sansFallback,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 18 / 14,
    leadingDistribution: TextLeadingDistribution.even,
    color: AppColors.textPrimary,
  );
}
