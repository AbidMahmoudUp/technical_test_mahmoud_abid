import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../providers/register_provider.dart';

final _smallStyle = AppTextStyles.caption.copyWith(
  fontSize: 12,
  height: 16 / 12,
);

// Keeps rows at 16px even when a glyph falls back to another font.
final _strut = StrutStyle.fromTextStyle(_smallStyle, forceStrutHeight: true);

/// Live checklist of the password rules with the strength on the right.
class PasswordRules extends StatelessWidget {
  const PasswordRules({super.key});

  @override
  Widget build(BuildContext context) {
    final register = context.watch<RegisterProvider>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final rule in PasswordRule.values)
                _RuleRow(label: rule.label, met: register.isRuleMet(rule)),
            ],
          ),
        ),
        _StrengthLabel(strength: register.passwordStrength),
      ],
    );
  }
}

class _RuleRow extends StatelessWidget {
  const _RuleRow({required this.label, required this.met});

  final String label;
  final bool met;

  @override
  Widget build(BuildContext context) {
    final color = met ? AppColors.textPrimary : AppColors.textSecondary;

    return Row(
      children: [
        Icon(Icons.check, size: 12, color: color),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            label,
            style: _smallStyle.copyWith(color: color),
            strutStyle: _strut,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _StrengthLabel extends StatelessWidget {
  const _StrengthLabel({required this.strength});

  final PasswordStrength strength;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'Password strength',
          style: _smallStyle.copyWith(color: AppColors.textSecondary),
        ),
        Text(
          strength.label,
          style: _smallStyle.copyWith(color: strength.color),
        ),
      ],
    );
  }
}
