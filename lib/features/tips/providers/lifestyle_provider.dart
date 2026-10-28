import 'package:flutter/foundation.dart';

import '../models/tobacco_use.dart';

class LifestyleProvider extends ChangeNotifier {
  TobaccoUse? _tobaccoUse;
  TobaccoUse? get tobaccoUse => _tobaccoUse;

  /// Answer highlighted on the question screen until it is confirmed.
  TobaccoUse _tobaccoDraft = TobaccoUse.never;
  TobaccoUse get tobaccoDraft => _tobaccoDraft;

  final int weightKg = 60;
  final int heightCm = 165;
  final String sex = 'Female';
  final DateTime birthDate = DateTime(1990, 8, 17);

  String get birthDateLabel {
    String twoDigits(int value) => value.toString().padLeft(2, '0');
    return '${twoDigits(birthDate.day)}.${twoDigits(birthDate.month)}.${birthDate.year}';
  }

  void startTobaccoQuestion() {
    _tobaccoDraft = _tobaccoUse ?? TobaccoUse.never;
    notifyListeners();
  }

  void selectTobaccoDraft(TobaccoUse value) {
    if (value == _tobaccoDraft) return;
    _tobaccoDraft = value;
    notifyListeners();
  }

  void confirmTobaccoUse() {
    _tobaccoUse = _tobaccoDraft;
    notifyListeners();
  }
}
