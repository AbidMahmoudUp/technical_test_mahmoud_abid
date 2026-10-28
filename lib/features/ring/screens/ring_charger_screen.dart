import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/routing/app_routes.dart';
import '../../../shared/widgets/app_button.dart';
import '../providers/ring_onboarding_provider.dart';
import '../widgets/ring_illustration.dart';
import '../widgets/ring_step_layout.dart';

class RingChargerScreen extends StatelessWidget {
  const RingChargerScreen({super.key});

  void _continue(BuildContext context) {
    context.read<RingOnboardingProvider>().reset();
    Navigator.pushNamed(context, AppRoutes.ringGuide);
  }

  @override
  Widget build(BuildContext context) {
    return RingStepLayout(
      onBack: () => Navigator.maybePop(context),
      illustration: const RingIllustration(
        asset: AppAssets.ringOnCharger,
        width: 180,
        height: 201,
        padding: EdgeInsets.only(top: 54),
      ),
      title: 'Place your ring on\nthe charger',
      paragraphs: const [
        TextSpan(
          text:
              'Align the Velia logo with the dot on the charger. '
              'This is how you’ll charge your ring.',
        ),
        TextSpan(
          text:
              'Make sure that bluetooth is enabled on your phone. When the '
              'green lights begin to glow inside the ring, tap ‘Continue’.',
        ),
      ],
      actions: [
        AppButton(label: 'Continue', onPressed: () => _continue(context)),
      ],
    );
  }
}
