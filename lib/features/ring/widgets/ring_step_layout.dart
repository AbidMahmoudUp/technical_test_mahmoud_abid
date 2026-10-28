import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/app_top_bar.dart';
import '../../../shared/widgets/gradient_background.dart';

/// Centred "illustration, title, paragraphs, actions" layout shared by the
/// ring setup screens.
class RingStepLayout extends StatelessWidget {
  const RingStepLayout({
    super.key,
    required this.illustration,
    required this.title,
    required this.paragraphs,
    required this.actions,
    this.onBack,
  });

  /// Placed at the top of a fixed-height slot so titles line up across steps.
  final Widget illustration;
  final String title;
  final List<InlineSpan> paragraphs;
  final List<Widget> actions;
  final VoidCallback? onBack;

  static const _illustrationSlot = 295.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              AppTopBar(onBack: onBack),
              SizedBox(
                height: _illustrationSlot,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: illustration,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.title,
                    ),
                    const SizedBox(height: 12),
                    for (final (i, paragraph) in paragraphs.indexed) ...[
                      if (i > 0) const SizedBox(height: 10),
                      Text.rich(
                        paragraph,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    for (final (i, action) in actions.indexed) ...[
                      if (i > 0) const SizedBox(height: 16),
                      action,
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
