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

  Future<void> typeInto(WidgetTester tester, Finder field, String text) async {
    await tester.enterText(field, text);
    await tester.pump();
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

  testWidgets('Create account runs register and ring onboarding to the tips', (
    tester,
  ) async {
    await pumpApp(tester);

    await tapText(tester, 'Create account');
    expect(find.text('Let’s get started'), findsOneWidget);
    await typeInto(tester, find.byType(TextField), 'jane@velia.com');
    await tapText(tester, 'Continue');

    expect(find.text('Set up a password'), findsOneWidget);
    await typeInto(tester, find.byType(TextField).first, 'Velia#2026');
    await typeInto(tester, find.byType(TextField).last, 'Velia#2026');
    await tapText(tester, 'Continue');

    expect(find.text('What is your date of birth?'), findsOneWidget);
    final dateFields = find.byType(TextField);
    await typeInto(tester, dateFields.at(0), '17');
    await typeInto(tester, dateFields.at(1), '08');
    await typeInto(tester, dateFields.at(2), '1990');
    await tapText(tester, 'Continue');

    expect(find.text('What is your height?'), findsOneWidget);
    await tapText(tester, 'Continue');

    expect(find.text('Let’s start'), findsOneWidget);
    await tapText(tester, 'Connect your ring');
    await tapText(tester, 'Continue');
    while (find.text('Most powerful tips').evaluate().isEmpty) {
      await tester.tap(find.byType(TextButton).last);
      await tester.pumpAndSettle();
    }

    expect(find.text('Most powerful tips'), findsOneWidget);
  });
}
