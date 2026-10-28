import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/routing/app_routes.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_top_bar.dart';
import '../../../shared/widgets/gradient_background.dart';
import '../models/ring_guide_step.dart';
import '../providers/ring_onboarding_provider.dart';
import '../widgets/guide_page.dart';
import '../widgets/segmented_progress.dart';

/// Swipeable guide (sync, battery, highlights). The page index lives in
/// [RingOnboardingProvider]; the [PageController] only drives the animation.
class RingGuideScreen extends StatefulWidget {
  const RingGuideScreen({super.key});

  @override
  State<RingGuideScreen> createState() => _RingGuideScreenState();
}

class _RingGuideScreenState extends State<RingGuideScreen> {
  static const _pageDuration = Duration(milliseconds: 350);

  late final PageController _controller = PageController(
    initialPage: context.read<RingOnboardingProvider>().index,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animateTo(int page) {
    _controller.animateToPage(
      page,
      duration: _pageDuration,
      curve: Curves.easeInOut,
    );
  }

  void _onContinue() {
    final onboarding = context.read<RingOnboardingProvider>();
    if (onboarding.isLastPage) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.tips,
        ModalRoute.withName(AppRoutes.welcome),
      );
      return;
    }
    onboarding.next();
    _animateTo(onboarding.index);
  }

  void _onBack() {
    final onboarding = context.read<RingOnboardingProvider>();
    onboarding.previous();
    _animateTo(onboarding.index);
  }

  @override
  Widget build(BuildContext context) {
    final onboarding = context.watch<RingOnboardingProvider>();
    final step = onboarding.currentStep;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              AppTopBar(onBack: onboarding.isFirstPage ? null : _onBack),
              Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: onboarding.goTo,
                  children: [
                    for (final step in onboarding.steps) GuidePage(step: step),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 33, 16, 8),
                child: Column(
                  children: [
                    SegmentedProgress(
                      total: RingGuideStep.totalProgress,
                      filled: step.progress,
                    ),
                    const SizedBox(height: 24),
                    AppButton(label: step.actionLabel, onPressed: _onContinue),
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
