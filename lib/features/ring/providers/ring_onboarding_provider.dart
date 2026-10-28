import 'package:flutter/foundation.dart';

import '../../../core/constants/app_assets.dart';
import '../models/ring_guide_step.dart';

/// Holds the current page of the ring guide and of its photo carousel.
class RingOnboardingProvider extends ChangeNotifier {
  final List<RingGuideStep> steps = RingGuideStep.values;

  /// Lifestyle photos on the last guide page; the carousel opens centred on
  /// the hand holding the ring.
  final List<String> highlightPhotos = const [
    AppAssets.ringMatters1,
    AppAssets.ringMatters2,
    AppAssets.ringMatters3,
  ];
  static const _initialHighlight = 1;

  int _index = 0;
  int _highlightIndex = _initialHighlight;

  int get index => _index;
  int get pageCount => steps.length;
  RingGuideStep get currentStep => steps[_index];
  bool get isFirstPage => _index == 0;
  bool get isLastPage => _index == pageCount - 1;

  int get highlightIndex => _highlightIndex;

  void goTo(int index) {
    final clamped = index.clamp(0, pageCount - 1);
    if (clamped == _index) return;
    _index = clamped;
    notifyListeners();
  }

  void next() => goTo(_index + 1);

  void previous() => goTo(_index - 1);

  void showHighlight(int index) {
    if (index == _highlightIndex) return;
    _highlightIndex = index;
    notifyListeners();
  }

  void reset() {
    _index = 0;
    _highlightIndex = _initialHighlight;
    notifyListeners();
  }
}
