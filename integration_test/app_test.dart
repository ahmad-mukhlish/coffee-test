import 'package:coffee_test/main_test.dart' as app;
import 'package:coffee_test/screens/login.dart';
import 'package:coffee_test/screens/menu.dart';
import 'package:coffee_test/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    "Loading -> tab login button -> see login screen",
    (WidgetTester tester) async {
      app.main();
      await tester.pump();

      expect(find.byType(SplashScreen), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 3));

      final homeLoginButton = find.byKey(const Key('homeLoginButton'));

      expect(homeLoginButton, findsOneWidget);

      await tester.tap(homeLoginButton);

      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
    },
  );

  testWidgets(
    "Loading -> tab login button -> enter correct username password -> see MenuScreen",
    (WidgetTester tester) async {
      app.main();
      await tester.pump();
      await tester.pumpAndSettle(const Duration(seconds: 3));
      final homeLoginButton = find.byKey(const Key('homeLoginButton'));
      await tester.tap(homeLoginButton);
      await tester.pumpAndSettle();

      Finder emailField = find.byKey(const Key('email'));
      expect(emailField, findsOneWidget);
      await tester.enterText(emailField, 'ahmad@gmail.com');

      Finder passwordField = find.byKey(const Key('password'));
      expect(passwordField, findsOneWidget);
      await tester.enterText(passwordField, 'securepassword');

      await tester.tap(find.byKey(const Key('signIn')));

      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(find.byType(SnackBar), findsNothing);
      expect(find.byType(MenuScreen), findsOneWidget);
    },
  );
}
