import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_button.dart';
import '../widgets/ring_illustration.dart';
import '../widgets/ring_step_layout.dart';

class RingStartScreen extends StatelessWidget {
  const RingStartScreen({super.key});

  static const _highlight = TextStyle(color: AppColors.textPrimary);

  @override
  Widget build(BuildContext context) {
    return RingStepLayout(
      illustration: const RingIllustration(
        asset: AppAssets.ringChargingStation,
        width: 325,
        height: 178,
        padding: EdgeInsets.only(top: 107, right: 13),
      ),
      title: 'Let’s start',
      paragraphs: const [
        TextSpan(
          text:
              'Connect the charging station to a good quality power adapter '
              'using the USB-C cable.',
        ),
        TextSpan(
          children: [
            TextSpan(text: 'The light on the top of the '),
            TextSpan(
              text: 'charging station will glow a steady green',
              style: _highlight,
            ),
            TextSpan(text: ' when it’s ready.'),
          ],
        ),
      ],
      actions: [
        AppButton(
          label: 'Connect your ring',
          onPressed: () => Navigator.pushNamed(context, AppRoutes.ringCharger),
        ),
        AppButton.secondary(
          label: 'Connect later',
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.tips,
            ModalRoute.withName(AppRoutes.welcome),
          ),
        ),
      ],
    );
  }
}
