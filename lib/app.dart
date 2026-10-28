import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/routing/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'features/register/providers/register_provider.dart';
import 'features/register/register_routes.dart';
import 'features/ring/providers/ring_onboarding_provider.dart';
import 'features/ring/ring_routes.dart';
import 'features/tips/providers/lifestyle_provider.dart';
import 'features/tips/providers/tips_provider.dart';
import 'features/tips/tips_routes.dart';
import 'features/welcome/welcome_screen.dart';

class VeliaApp extends StatelessWidget {
  const VeliaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TipsProvider()),
        ChangeNotifierProvider(create: (_) => LifestyleProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => RingOnboardingProvider()),
      ],
      child: MaterialApp(
        title: 'Velia',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        initialRoute: AppRoutes.welcome,
        routes: {
          AppRoutes.welcome: (_) => const WelcomeScreen(),
          ...tipsRoutes,
          ...registerRoutes,
          ...ringRoutes,
        },
      ),
    );
  }
}
