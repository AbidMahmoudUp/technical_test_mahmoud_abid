import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_top_bar.dart';
import '../../../shared/widgets/gradient_background.dart';
import '../models/tobacco_use.dart';
import '../providers/lifestyle_provider.dart';
import '../widgets/option_tile.dart';

class TobaccoQuestionScreen extends StatelessWidget {
  const TobaccoQuestionScreen({super.key});

  static const _buttonHeight = 64.0;
  static const _buttonBottomGap = 8.0;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final selected = context.select<LifestyleProvider, TobaccoUse>(
      (lifestyle) => lifestyle.tobaccoDraft,
    );

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              AppTopBar(onClose: () => Navigator.pop(context)),
              Expanded(
                child: Stack(
                  children: [
                    ListView(
                      padding: EdgeInsets.fromLTRB(
                        16,
                        9,
                        16,
                        bottomInset + _buttonBottomGap + _buttonHeight + 16,
                      ),
                      children: [
                        const Text(
                          'Do you currently smoke or use tobacco products?',
                          style: AppTextStyles.title,
                        ),
                        const SizedBox(height: 19),
                        for (final option in TobaccoUse.values) ...[
                          OptionTile(
                            label: option.label,
                            description: option.description,
                            selected: option == selected,
                            onTap: () => context
                                .read<LifestyleProvider>()
                                .selectTobaccoDraft(option),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ],
                    ),
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: bottomInset + _buttonBottomGap,
                      child: AppButton(
                        label: 'Continue',
                        onPressed: () {
                          context.read<LifestyleProvider>().confirmTobaccoUse();
                          Navigator.pop(context);
                        },
                      ),
                    ),
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
