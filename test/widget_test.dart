import 'package:flutter_test/flutter_test.dart';

import 'package:technical_test_mahmoud_abid/app.dart';

void main() {
  testWidgets('Welcome screen shows both entry points', (tester) async {
    await tester.pumpWidget(const VeliaApp());

    expect(find.text('Welcome to Velia'), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);
    expect(find.text('Create account'), findsOneWidget);
  });
}
