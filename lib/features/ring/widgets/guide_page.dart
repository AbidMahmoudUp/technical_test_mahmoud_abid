import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/ring_guide_step.dart';
import 'app_tile_row.dart';
import 'battery_legend_card.dart';
import 'photo_card_row.dart';
import 'ring_illustration.dart';

/// One swipeable page of the ring guide: serif heading, illustration at a
/// fixed height, and copy anchored to the bottom.
class GuidePage extends StatelessWidget {
  const GuidePage({super.key, required this.step});

  final RingGuideStep step;

  static const _headingStyle = AppTextStyles.display;

  ({double top, Widget child}) get _illustration => switch (step) {
    RingGuideStep.sync => (top: 202, child: const AppTileRow()),
    RingGuideStep.battery => (top: 183, child: const _DoubleTapIllustration()),
    RingGuideStep.highlights => (top: 202, child: const PhotoCardRow()),
  };

  @override
  Widget build(BuildContext context) {
    final illustration = _illustration;
    return Stack(
      children: [
        Positioned(
          top: illustration.top,
          left: 0,
          right: 0,
          child: Center(child: illustration.child),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(step.title, style: _headingStyle),
              const Spacer(),
              Text(step.body, style: AppTextStyles.body),
              if (step == RingGuideStep.battery) ...[
                const SizedBox(height: 16),
                const BatteryLegendCard(),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// Ring render with the glassy tapping-finger overlay on its right side.
class _DoubleTapIllustration extends StatelessWidget {
  const _DoubleTapIllustration();

  static const _boxWidth = 227.0;
  static const _boxHeight = 196.0;

  /// Ring export size and tilt from Figma.
  static const _ringWidth = 187.25;
  static const _ringHeight = 161.64;
  static const _ringAngle = -30 * math.pi / 180;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _boxWidth,
      height: _boxHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: -2,
            top: 9,
            child: Transform.rotate(
              angle: _ringAngle,
              child: const RingIllustration(
                asset: AppAssets.ringDoubleTap,
                width: _ringWidth,
                height: _ringHeight,
              ),
            ),
          ),
          Positioned(
            left: 121,
            top: 69,
            child: SvgPicture.asset(
              AppAssets.ringDoubleTapHand,
              width: 133,
              height: 157,
            ),
          ),
        ],
      ),
    );
  }
}
