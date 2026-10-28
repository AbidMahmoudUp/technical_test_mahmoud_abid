import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_text_styles.dart';

class BrandHeader extends StatelessWidget {
  const BrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        _GlowingLogo(),
        SizedBox(width: 10),
        Text('Welcome to Velia', style: AppTextStyles.caption),
      ],
    );
  }
}

/// Logo with the soft 40% blurred halo from Figma behind it.
class _GlowingLogo extends StatelessWidget {
  const _GlowingLogo();

  static const _width = 25.0;
  static const _height = 21.0;

  @override
  Widget build(BuildContext context) {
    final logo = SvgPicture.asset(
      AppAssets.logo,
      width: _width,
      height: _height,
    );

    return SizedBox(
      width: _width,
      height: _height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Opacity(
            opacity: 0.4,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: 6,
                sigmaY: 6,
                tileMode: TileMode.decal,
              ),
              child: logo,
            ),
          ),
          logo,
        ],
      ),
    );
  }
}
