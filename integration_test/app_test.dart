import 'package:coffee_test/main_test.dart' as app;
import 'package:coffee_test/screens/login.dart';
import 'package:coffee_test/screens/menu.dart';
import 'package:coffee_test/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  //setup the integration test
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    "Loading -> tab login button -> see login screen",
    (WidgetTester tester) async {
      //loads the app
      app.main();

      //rebuild the widget
      await tester.pump();

      //test the widget - must be found exactly one
      expect(find.byType(SplashScreen), findsOneWidget);

      //pumps until the last frame for duration
      await tester.pumpAndSettle(const Duration(seconds: 3));

      final homeLoginButton = find.byKey(const Key('loginButton'));

      expect(homeLoginButton, findsOneWidget);

      //tap this widget
      await tester.tap(homeLoginButton);

      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
    },
  );

  testWidgets(
    "Loading -> tab login button ->"
    " enter correct username password -> see MenuScreen",
    (WidgetTester tester) async {
      app.main();
      await tester.pump();
      await tester.pumpAndSettle(const Duration(seconds: 3));
      final homeLoginButton = find.byKey(const Key('loginButton'));
      await tester.tap(homeLoginButton);
      await tester.pumpAndSettle();

      Finder emailField = find.byKey(const Key('email'));
      expect(emailField, findsOneWidget);

      //enter text in the field
      await tester.enterText(emailField, 'ahmad@gmail.com');

      Finder passwordField = find.byKey(const Key('password'));
      expect(passwordField, findsOneWidget);
      await tester.enterText(passwordField, 'securepassword');

      await tester.tap(find.byKey(const Key('signIn')));

      await tester.pumpAndSettle(const Duration(seconds: 5));

      //should not find error by showing snackbar
      expect(find.byType(SnackBar), findsNothing);

      expect(find.byType(MenuScreen), findsOneWidget);
    },
  );
}
