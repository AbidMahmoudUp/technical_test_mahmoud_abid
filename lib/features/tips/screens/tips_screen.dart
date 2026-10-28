import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/app_top_bar.dart';
import '../../../shared/widgets/glass_card.dart';
import '../widgets/lifestyle_panel.dart';
import '../widgets/section_panel.dart';
import '../widgets/tips_carousel.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  static const _headerColor = Color(0xFF6F727C);
  static const _panelGap = 9.0;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);

    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: _TipsBackground()),
          ListView(
            padding: EdgeInsets.fromLTRB(
              16,
              padding.top + AppTopBar.height,
              16,
              padding.bottom + 8,
            ),
            children: const [
              _TipsPanel(),
              SizedBox(height: _panelGap),
              LifestylePanel(),
              SizedBox(height: _panelGap),
              _LearnMoreButton(),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: ColoredBox(
                  color: _headerColor.withValues(alpha: 0.96),
                  child: SafeArea(
                    bottom: false,
                    child: AppTopBar(onBack: () => Navigator.pop(context)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Landscape photo darkened to navy; it only shows around the panels and
/// fades out completely halfway down the screen.
class _TipsBackground extends StatelessWidget {
  const _TipsBackground();

  static const _overlay = AppColors.background;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          AppAssets.tipsBackground,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0, 0.14, 0.21, 0.3, 0.5],
              colors: [
                _overlay.withValues(alpha: 0.5),
                _overlay.withValues(alpha: 0.55),
                _overlay.withValues(alpha: 0.67),
                _overlay.withValues(alpha: 0.88),
                _overlay,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TipsPanel extends StatelessWidget {
  const _TipsPanel();

  @override
  Widget build(BuildContext context) {
    return const SectionPanel(
      icon: Icons.rocket_launch_outlined,
      label: 'Most powerful tips',
      topPadding: 8,
      headerSpacing: 48,
      bottomPadding: 47,
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0, 0.2, 0.55, 1],
        colors: [
          TipsScreen._headerColor,
          Color(0xFF3E3D48),
          Color(0xFF121A2B),
          Color(0xFF0C1424),
        ],
      ),
      child: TipsCarousel(),
    );
  }
}

class _LearnMoreButton extends StatelessWidget {
  const _LearnMoreButton();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: () {},
      radius: 26,
      outline: GlassCard.hairline,
      child: const SizedBox(
        height: 52,
        child: Center(child: Text('Learn more', style: AppTextStyles.label)),
      ),
    );
  }
}
