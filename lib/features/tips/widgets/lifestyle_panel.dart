import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/routing/app_routes.dart';
import '../providers/lifestyle_provider.dart';
import 'lifestyle_chip.dart';
import 'section_panel.dart';

class LifestylePanel extends StatelessWidget {
  const LifestylePanel({super.key});

  static const _gap = 4.0;

  void _openTobaccoQuestion(BuildContext context) {
    context.read<LifestyleProvider>().startTobaccoQuestion();
    Navigator.pushNamed(context, AppRoutes.tobaccoQuestion);
  }

  @override
  Widget build(BuildContext context) {
    final lifestyle = context.watch<LifestyleProvider>();
    final tobaccoUse = lifestyle.tobaccoUse;

    return SectionPanel(
      icon: Icons.person_outline,
      label: 'Your lifestyle',
      border: const Color(0x21FFFFFF),
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0x0FFFFFFF), Color(0x05FFFFFF)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SectionPanel.horizontalPadding,
            ),
            child: Wrap(
              spacing: _gap,
              runSpacing: _gap,
              children: [
                tobaccoUse == null
                    ? LifestyleChip.add(
                        label: 'Tobacco use',
                        onTap: () => _openTobaccoQuestion(context),
                      )
                    : LifestyleChip.value(
                        label: tobaccoUse.label,
                        onTap: () => _openTobaccoQuestion(context),
                      ),
                const LifestyleChip.add(label: 'Alcohol use'),
                const LifestyleChip.add(label: 'Physical activity'),
                const LifestyleChip.add(label: 'Stress levels'),
              ],
            ),
          ),
          const SizedBox(height: _gap),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: SectionPanel.horizontalPadding,
              ),
              children: [
                for (final value in [
                  '${lifestyle.weightKg} kg',
                  '${lifestyle.heightCm} cm',
                  lifestyle.sex,
                  lifestyle.birthDateLabel,
                ])
                  Padding(
                    padding: const EdgeInsets.only(right: _gap),
                    child: LifestyleChip.value(label: value),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
