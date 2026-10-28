import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class BatteryLegendEntry {
  const BatteryLegendEntry({
    required this.color,
    required this.label,
    required this.meaning,
  });

  final Color color;
  final String label;
  final String meaning;
}

/// Card explaining what each ring light colour means.
class BatteryLegendCard extends StatelessWidget {
  const BatteryLegendCard({super.key, this.entries = defaultEntries});

  final List<BatteryLegendEntry> entries;

  static const defaultEntries = [
    BatteryLegendEntry(
      color: Color(0xFF80BC52),
      label: 'Green',
      meaning: 'Charged',
    ),
    BatteryLegendEntry(
      color: Color(0xFFBC5252),
      label: 'Red',
      meaning: 'Below 30%',
    ),
    BatteryLegendEntry(
      color: AppColors.textSecondary,
      label: 'No light',
      meaning: 'Time to recharge',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0x0DFFFFFF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        spacing: 8,
        children: [for (final entry in entries) _LegendRow(entry: entry)],
      ),
    );
  }
}

const _legendStyle = TextStyle(
  fontFamily: AppTextStyles.sans,
  fontFamilyFallback: ['Inter'],
  fontSize: 12,
  height: 16 / 12,
  leadingDistribution: TextLeadingDistribution.even,
);

class _LegendRow extends StatelessWidget {
  const _LegendRow({required this.entry});

  final BatteryLegendEntry entry;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(left: 2, right: 6),
                decoration: BoxDecoration(
                  color: entry.color,
                  shape: BoxShape.circle,
                ),
              ),
              Text(
                entry.label,
                style: _legendStyle.copyWith(color: entry.color),
              ),
            ],
          ),
          Text(
            entry.meaning,
            style: _legendStyle.copyWith(color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
