import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';

/// Mountain photo pinned to the top, fading into the app background.
class WelcomeBackground extends StatelessWidget {
  const WelcomeBackground({super.key});

  static const _imageSize = 560.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -4,
          left: -58,
          width: _imageSize,
          height: _imageSize,
          child: Image.asset(AppAssets.welcomeBackground, fit: BoxFit.cover),
        ),
        Positioned(
          top: -4,
          left: 0,
          right: 0,
          height: _imageSize,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.6, 0.95],
                colors: [
                  AppColors.background.withValues(alpha: 0),
                  AppColors.background,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
