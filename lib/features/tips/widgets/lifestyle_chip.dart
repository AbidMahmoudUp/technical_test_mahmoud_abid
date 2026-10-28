import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// 40px chip. [LifestyleChip.add] is outlined with a plus (nothing logged yet),
/// [LifestyleChip.value] is filled with a caret (a value to edit).
class LifestyleChip extends StatelessWidget {
  const LifestyleChip.add({super.key, required this.label, this.onTap})
    : _filled = false;

  const LifestyleChip.value({super.key, required this.label, this.onTap})
    : _filled = true;

  final String label;
  final VoidCallback? onTap;
  final bool _filled;

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: _filled
          ? BorderSide.none
          : const BorderSide(color: AppColors.borderStrong),
    );

    return Material(
      color: _filled ? AppColors.surfaceRaised : Colors.transparent,
      shape: shape,
      child: InkWell(
        onTap: onTap,
        customBorder: shape,
        child: Container(
          height: 40,
          padding: const EdgeInsets.fromLTRB(16, 8, 12, 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, style: AppTextStyles.label),
              const SizedBox(width: 10),
              Icon(
                _filled ? Icons.arrow_right : Icons.add,
                size: 14,
                color: AppColors.textPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
