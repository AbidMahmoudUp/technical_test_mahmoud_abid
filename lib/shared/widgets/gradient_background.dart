import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Navy page background that fades from a lighter blue at the top.
class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0, 0.38],
          colors: [AppColors.backgroundTop, AppColors.background],
        ),
      ),
      child: child,
    );
  }
}
