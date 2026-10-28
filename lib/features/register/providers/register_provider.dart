import 'package:flutter/material.dart';

enum PasswordRule {
  lowercase('1 lowercase letter'),
  number('1 number'),
  uppercase('1 uppercase letter'),
  special('1 special character'),
  length('8 characters');

  const PasswordRule(this.label);

  final String label;
}

enum PasswordStrength {
  weak('Weak', Color(0xFFD9685B)),
  fair('Fair', Color(0xFFD99A5B)),
  good('Good', Color(0xFFD9C65B)),
  great('Great', Color(0xFF5A9380));

  const PasswordStrength(this.label, this.color);

  final String label;
  final Color color;
}

enum HeightUnit { ftIn, cm }

/// Holds everything the user enters during the register flow.
class RegisterProvider extends ChangeNotifier {
  static const minPasswordLength = 8;
  static const feetRange = (min: 1, max: 8);
  static const inchesRange = (min: 0, max: 11);
  static const cmRange = (min: 50, max: 250);

  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]{2,}$');

  // Email
  String _email = '';
  String get email => _email;
  bool get isEmailValid => _emailPattern.hasMatch(_email);
  bool get canContinueEmail => isEmailValid;

  void setEmail(String value) {
    _email = value.trim();
    notifyListeners();
  }

  // Password
  String _password = '';
  String _confirmation = '';
  bool _obscurePassword = true;
  bool _obscureConfirmation = true;

  String get password => _password;
  String get confirmation => _confirmation;
  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirmation => _obscureConfirmation;

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void setConfirmation(String value) {
    _confirmation = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmationVisibility() {
    _obscureConfirmation = !_obscureConfirmation;
    notifyListeners();
  }

  bool isRuleMet(PasswordRule rule) => switch (rule) {
    PasswordRule.lowercase => _password.contains(RegExp('[a-z]')),
    PasswordRule.number => _password.contains(RegExp('[0-9]')),
    PasswordRule.uppercase => _password.contains(RegExp('[A-Z]')),
    PasswordRule.special => _password.contains(RegExp(r'[^A-Za-z0-9\s]')),
    PasswordRule.length => _password.length >= minPasswordLength,
  };

  int get metRulesCount => PasswordRule.values.where(isRuleMet).length;

  PasswordStrength get passwordStrength => switch (metRulesCount) {
    5 => PasswordStrength.great,
    4 => PasswordStrength.good,
    3 => PasswordStrength.fair,
    _ => PasswordStrength.weak,
  };

  bool get passwordsMatch => _password == _confirmation;

  bool get canContinuePassword =>
      _password.length >= minPasswordLength && passwordsMatch;

  // Date of birth
  String _day = '';
  String _month = '';
  String _year = '';

  String get day => _day;
  String get month => _month;
  String get year => _year;

  void setDay(String value) => _setDatePart(() => _day = value);
  void setMonth(String value) => _setDatePart(() => _month = value);
  void setYear(String value) => _setDatePart(() => _year = value);

  void _setDatePart(VoidCallback update) {
    update();
    notifyListeners();
  }

  DateTime? get birthDate {
    final d = int.tryParse(_day);
    final m = int.tryParse(_month);
    final y = int.tryParse(_year);
    if (d == null || m == null || y == null || _year.length != 4) return null;
    final date = DateTime(y, m, d);
    final isRealDate = date.year == y && date.month == m && date.day == d;
    if (!isRealDate || y < 1900 || date.isAfter(DateTime.now())) return null;
    return date;
  }

  bool get isBirthDateValid => birthDate != null;
  bool get canContinueBirthDate => isBirthDateValid;

  // Height
  HeightUnit _heightUnit = HeightUnit.ftIn;
  int _feet = 5;
  int _inches = 7;
  int _centimeters = 170;

  HeightUnit get heightUnit => _heightUnit;
  int get feet => _feet;
  int get inches => _inches;
  int get centimeters => _centimeters;
  bool get canContinueHeight => true;

  void setHeightUnit(HeightUnit unit) {
    if (unit == _heightUnit) return;
    if (unit == HeightUnit.cm) {
      _centimeters = ((_feet * 12 + _inches) * 2.54).round().clamp(
        cmRange.min,
        cmRange.max,
      );
    } else {
      final totalInches = (_centimeters / 2.54).round();
      _feet = (totalInches ~/ 12).clamp(feetRange.min, feetRange.max);
      _inches = totalInches % 12;
    }
    _heightUnit = unit;
    notifyListeners();
  }

  void setFeet(int value) {
    _feet = value;
    notifyListeners();
  }

  void setInches(int value) {
    _inches = value;
    notifyListeners();
  }

  void setCentimeters(int value) {
    _centimeters = value;
    notifyListeners();
  }

  /// Clears everything so a new sign-up starts from blank fields.
  void reset() {
    _email = '';
    _password = '';
    _confirmation = '';
    _obscurePassword = true;
    _obscureConfirmation = true;
    _day = '';
    _month = '';
    _year = '';
    _heightUnit = HeightUnit.ftIn;
    _feet = 5;
    _inches = 7;
    _centimeters = 170;
    notifyListeners();
  }
}
