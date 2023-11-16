import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'coffee_router.dart';
import 'data_providers/auth_data_provider.dart';
import 'data_providers/auth_provider.dart';
import 'data_providers/http_client.dart';
import 'screens/get_theme.dart';
import 'screens/splash_screen.dart';

bool get isInDebugMode {
  bool inDebugMode = false;
  // assert(inDebugMode = true);
  return inDebugMode;
}

Future<void> main() async {
  if (isInDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }
  // Flutter >= 1.17 and Dart >= 2.8
  runZonedGuarded<Future<void>>(() async {
    runApp(
      AuthProvider(
        auth: AuthDataProvider(http: HttpClient()),
        key: const Key("try"),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          home: const SplashScreen(),
          navigatorKey: CoffeeRouter.instance.navigatorKey,
          theme: getTheme(),
        ),
      ),
    );

    await Firebase.initializeApp();
  }, (error, stackTrace) async {
    debugPrint('$error');
    debugPrint('$stackTrace');

    // if (kDebugMode) {
    //   print('Caught Dart Error!');
    // }
    // if (isInDebugMode) {
    //   // in development, print error and stack trace
    //   if (kDebugMode) {
    //     print('$error');
    //   }
    //   if (kDebugMode) {
    //     print('$stackTrace');
    //   }
    // } else {
    //   // report to a error tracking system in production
    //   FirebaseCrashlytics.instance.recordError(error, stackTrace);
    // }
  });

  // You only need to call this method if you need the binding to be initialized before calling runApp.
  WidgetsFlutterBinding.ensureInitialized();
  // This captures errors reported by the Flutter framework.
  FlutterError.onError = (FlutterErrorDetails details) async {
    final dynamic exception = details.exception;
    final StackTrace? stackTrace = details.stack;
    if (isInDebugMode) {
      if (kDebugMode) {
        print('Caught Framework Error!');
      }
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode report to the application zone
      Zone.current.handleUncaughtError(exception, stackTrace!);
    }
  };
}
