import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:technical_test_mahmoud_abid/app.dart';
import 'package:technical_test_mahmoud_abid/core/routing/app_routes.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(393, 852);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const VeliaApp());
  }

  Future<void> tapText(WidgetTester tester, String text) async {
    await tester.tap(find.text(text).last);
    await tester.pumpAndSettle();
  }

  testWidgets('Welcome screen shows both entry points', (tester) async {
    await pumpApp(tester);

    expect(find.text('Welcome to Velia'), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);
    expect(find.text('Create account'), findsOneWidget);
  });

  testWidgets('Log in opens the tips and the tobacco question', (tester) async {
    await pumpApp(tester);

    await tapText(tester, 'Log in');
    expect(find.text('Most powerful tips'), findsOneWidget);

    await tapText(tester, 'Tobacco use');
    expect(
      find.text('Do you currently smoke or use tobacco products?'),
      findsOneWidget,
    );

    await tapText(tester, 'Former smoker');
    await tapText(tester, 'Continue');
    expect(find.text('Former smoker'), findsOneWidget);
  });

  testWidgets('Ring setup and guide finish on the tips', (tester) async {
    await pumpApp(tester);

    tester.state<NavigatorState>(find.byType(Navigator)).pushNamed(
      AppRoutes.ringStart,
    );
    await tester.pumpAndSettle();
    expect(find.text('Let’s start'), findsOneWidget);

    await tapText(tester, 'Connect your ring');
    await tapText(tester, 'Continue');
    expect(find.text('Open your app\nto sync'), findsOneWidget);

    await tapText(tester, 'Continue');
    await tapText(tester, 'Continue');
    await tapText(tester, 'Start using Velia');
    expect(find.text('Most powerful tips'), findsOneWidget);
  });
}
