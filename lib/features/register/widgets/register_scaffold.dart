import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_top_bar.dart';
import '../../../shared/widgets/gradient_background.dart';

/// Common layout of a register step: back bar, title, optional subtitle,
/// the step content and a Continue button that rides above the keyboard.
class RegisterScaffold extends StatelessWidget {
  const RegisterScaffold({
    super.key,
    required this.title,
    required this.child,
    required this.onContinue,
    this.subtitle,
    this.topBarCenter,
  });

  final String title;
  final String? subtitle;
  final Widget? topBarCenter;
  final Widget child;

  /// Pass `null` to disable the Continue button.
  final VoidCallback? onContinue;

  @override
  Widget build(BuildContext context) {
    final keyboardVisible = MediaQuery.viewInsetsOf(context).bottom > 0;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTopBar(
                onBack: () => Navigator.maybePop(context),
                center: topBarCenter,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _StepHeader(title: title, subtitle: subtitle),
                      const SizedBox(height: 18),
                      child,
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  16,
                  0,
                  16,
                  keyboardVisible ? 16 : 8,
                ),
                child: AppButton(label: 'Continue', onPressed: onContinue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Forces the design line height even when a glyph falls back to another font.
StrutStyle _strut(TextStyle style) =>
    StrutStyle.fromTextStyle(style, forceStrutHeight: true);

class _StepHeader extends StatelessWidget {
  const _StepHeader({required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.title,
          strutStyle: _strut(AppTextStyles.title),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
            strutStyle: _strut(AppTextStyles.bodySmall),
          ),
        ],
      ],
    );
  }
}
