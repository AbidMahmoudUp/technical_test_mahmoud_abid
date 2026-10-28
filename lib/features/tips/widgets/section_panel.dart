import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// Rounded panel with an icon + label header, used for the tips and lifestyle
/// blocks. Children handle their own horizontal padding so carousels can bleed
/// to the panel edges.
class SectionPanel extends StatelessWidget {
  const SectionPanel({
    super.key,
    required this.icon,
    required this.label,
    required this.gradient,
    required this.child,
    this.border = AppColors.border,
    this.topPadding = 20,
    this.headerSpacing = 20,
    this.bottomPadding = 20,
  });

  final IconData icon;
  final String label;
  final Gradient gradient;
  final Color border;
  final double topPadding;
  final double headerSpacing;
  final double bottomPadding;
  final Widget child;

  static const horizontalPadding = 20.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: border),
      ),
      padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Row(
              children: [
                Icon(icon, size: 16, color: AppColors.textPrimary),
                const SizedBox(width: 8),
                Text(label, style: AppTextStyles.label),
              ],
            ),
          ),
          SizedBox(height: headerSpacing),
          child,
        ],
      ),
    );
  }
}
