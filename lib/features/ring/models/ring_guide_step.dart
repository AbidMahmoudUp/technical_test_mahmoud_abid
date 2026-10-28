/// Pages of the swipeable ring guide shown after the ring is on its charger.
enum RingGuideStep {
  sync(
    title: 'Open your app\nto sync',
    body:
        'Regular syncing helps build patterns over time, making your insights '
        'more meaningful. Sync at least every 2 days to avoid losing data.',
    progress: 2,
    actionLabel: 'Continue',
  ),
  battery(
    title: 'Double tap to\ncheck the battery',
    body:
        'That same double tap lets you check your battery without opening '
        'the app',
    progress: 4,
    actionLabel: 'Continue',
  ),
  highlights(
    title: 'Only what\nmatters, when it\nmatters',
    body:
        'Velia learns over time, unlocking more tailored insights as it '
        'calibrates.',
    progress: 5,
    actionLabel: 'Start using Velia',
  );

  const RingGuideStep({
    required this.title,
    required this.body,
    required this.progress,
    required this.actionLabel,
  });

  final String title;
  final String body;

  /// Number of lit segments in the onboarding progress indicator.
  final int progress;
  final String actionLabel;

  static const totalProgress = 5;
}
