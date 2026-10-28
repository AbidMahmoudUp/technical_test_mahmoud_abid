/// Single source of truth for asset paths.
///
/// File names here must match the exported files listed in assets/ASSETS.md.
abstract final class AppAssets {
  static const _images = 'assets/images';
  static const _icons = 'assets/icons';

  // Welcome
  static const welcomeBackground = '$_images/welcome_bg.png';
  static const logo = '$_icons/ic_logo.svg';

  // Most powerful tips section
  static const tipsBackground = '$_images/tips_bg.png';
  static const tipTrainArteries = '$_images/tip_train_arteries.png';
  static const tipFeed = '$_images/tip_feed.png';
  static const tipCalmSystem = '$_images/tip_calm_system.png';

  // Ring section
  static const ringChargingStation = '$_images/ring_charging_station.png';
  static const ringOnCharger = '$_images/ring_on_charger.png';
  static const ringDoubleTap = '$_images/ring_double_tap.png';
  static const ringMatters1 = '$_images/ring_matters_1.png';
  static const ringMatters2 = '$_images/ring_matters_2.png';
  static const ringMatters3 = '$_images/ring_matters_3.png';

  // Icons
  static const icBack = '$_icons/ic_back.svg';
  static const icClose = '$_icons/ic_close.svg';
  static const icEye = '$_icons/ic_eye.svg';
  static const icEyeOff = '$_icons/ic_eye_off.svg';
  static const icCheck = '$_icons/ic_check.svg';
  static const icRocket = '$_icons/ic_rocket.svg';
  static const icUser = '$_icons/ic_user.svg';
  static const icPlus = '$_icons/ic_plus.svg';
  static const icCaretRight = '$_icons/ic_caret_right.svg';
}
