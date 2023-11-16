import 'package:coffee_test/coffee_router.dart';
import 'package:coffee_test/data_providers/auth_data_provider.dart';
import 'package:coffee_test/data_providers/auth_provider.dart';
import 'package:coffee_test/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final loginScaffoldKey = GlobalKey<ScaffoldState>();

  Widget makeTestableWidget({required Widget child, BaseAuth? auth}) {
    return AuthProvider(
      auth: auth,
      key: const Key("try"),
      child: MaterialApp(
        home: child,
        navigatorKey: CoffeeRouter.instance.navigatorKey,
      ),
    );
  }

  testWidgets('LoginPage Golden', (WidgetTester tester) async {
    LoginScreen page = LoginScreen(
      scaffoldKey: loginScaffoldKey,
    );

    await tester.pumpWidget(
      makeTestableWidget(
        child: page,
      ),
    );

    await expectLater(
      find.byType(LoginScreen),
      matchesGoldenFile(
        'loginScreen.png',
        version: 2,
      ),
    );
  });
}
