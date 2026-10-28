import 'package:flutter/foundation.dart';

import '../../../core/constants/app_assets.dart';
import '../models/tip.dart';

class TipsProvider extends ChangeNotifier {
  final List<Tip> tips = const [
    Tip(
      title: 'Rest to repair',
      body: 'Sleep is when your cardiovascular system repairs itself.',
      image: AppAssets.tipTrainArteries,
    ),
    Tip(
      title: 'Train your arteries',
      body:
          'Move your body to keep your blood vessels flexible and your heart efficient.',
      image: AppAssets.tipTrainArteries,
    ),
    Tip(
      title: 'Feed your heart',
      body:
          'What you eat shapes your blood vessels, cholesterol, and inflammation levels.',
      image: AppAssets.tipTrainArteries,
    ),
  ];

  int _currentIndex = 1;
  int get currentIndex => _currentIndex;

  void showTip(int index) {
    if (index == _currentIndex) return;
    _currentIndex = index;
    notifyListeners();
  }
}
