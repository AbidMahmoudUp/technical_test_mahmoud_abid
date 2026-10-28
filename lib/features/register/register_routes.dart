import 'package:flutter/widgets.dart';

import '../../core/routing/app_routes.dart';
import 'screens/birth_date_screen.dart';
import 'screens/email_screen.dart';
import 'screens/height_screen.dart';
import 'screens/password_screen.dart';

final Map<String, WidgetBuilder> registerRoutes = {
  AppRoutes.registerEmail: (_) => const EmailScreen(),
  AppRoutes.registerPassword: (_) => const PasswordScreen(),
  AppRoutes.registerBirthDate: (_) => const BirthDateScreen(),
  AppRoutes.registerHeight: (_) => const HeightScreen(),
};
