import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routing/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/app_button.dart';
import '../register/providers/register_provider.dart';
import 'widgets/brand_header.dart';
import 'widgets/welcome_background.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: WelcomeBackground()),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BrandHeader(),
                  const SizedBox(height: 24),
                  const _Headline(),
                  const Spacer(),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 240),
                    child: Text(
                      'Gentle insights from a quiet companion that listens',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 27),
                  AppButton(
                    label: 'Log in',
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.tips),
                  ),
                  const SizedBox(height: 12),
                  AppButton.secondary(
                    label: 'Create account',
                    onPressed: () {
                      context.read<RegisterProvider>().reset();
                      Navigator.pushNamed(context, AppRoutes.registerEmail);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Headline extends StatelessWidget {
  const _Headline();

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      const TextSpan(
        children: [
          TextSpan(text: 'Stay '),
          TextSpan(
            text: 'connected',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          TextSpan(text: '\nto everyday\nbalance'),
        ],
      ),
      style: AppTextStyles.display,
    );
  }
}
