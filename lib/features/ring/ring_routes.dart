import 'package:flutter/widgets.dart';

import '../../core/routing/app_routes.dart';
import 'screens/ring_charger_screen.dart';
import 'screens/ring_guide_screen.dart';
import 'screens/ring_start_screen.dart';

final Map<String, WidgetBuilder> ringRoutes = {
  AppRoutes.ringStart: (_) => const RingStartScreen(),
  AppRoutes.ringCharger: (_) => const RingChargerScreen(),
  AppRoutes.ringGuide: (_) => const RingGuideScreen(),
};
