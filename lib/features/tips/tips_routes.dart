import 'package:flutter/widgets.dart';

import '../../core/routing/app_routes.dart';
import 'screens/tips_screen.dart';

final Map<String, WidgetBuilder> tipsRoutes = {
  AppRoutes.tips: (_) => const TipsScreen(),
};
