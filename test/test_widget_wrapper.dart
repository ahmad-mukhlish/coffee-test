import 'package:coffee_test/coffee_router.dart';
import 'package:coffee_test/data_providers/auth_data_provider.dart';
import 'package:coffee_test/data_providers/auth_provider.dart';
import 'package:flutter/material.dart';

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
