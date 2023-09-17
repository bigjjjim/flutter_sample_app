import 'dart:async';
import 'dart:isolate';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../UI/app.dart';
import '../../services/firebase_messaging.dart';
import '../../providers/auth_provider.dart';

void main() async {
  // Ensures that the widget binding is initialized before any other part of the app is accessed.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialise Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Firebase Analytics
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  // Enable Crashlytics data collection
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

  // Set up device orientation
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  if (kIsWeb) {
    // For web: Log errors to the console.
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
    };
    runApp(const MyApp());
  } else {
    requestPermissionNotif();
    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // For non-web platforms: Capture fatal Flutter errors with Crashlytics.
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);

      // Log the error event to Firebase Analytics
      analytics.logEvent(
        name: 'flutter_error',
        parameters: {
          'description': errorDetails.exceptionAsString(),
          'library': errorDetails.library,
          'isFatal': true,
        },
      );
    };

    // Capture unhandled asynchronous errors.
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);

      // Log the async error event to Firebase Analytics
      analytics.logEvent(
        name: 'async_error',
        parameters: {
          'description': error.toString(),
          'isFatal': true,
        },
      );

      return true;
    };

    // Capture errors outside of the Flutter context.
    Isolate.current.addErrorListener(RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      await FirebaseCrashlytics.instance.recordError(
        errorAndStacktrace.first,
        errorAndStacktrace.last,
        fatal: true,
      );

      // Log the isolate error event to Firebase Analytics
      analytics.logEvent(
        name: 'isolate_error',
        parameters: {
          'description': errorAndStacktrace.first.toString(),
          'isFatal': true,
        },
      );
    }).sendPort);

    runApp(const MyApp());
  }
}

requestPermissionNotif() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}

// handle background notification
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // print('Handling a background message ${message.messageId}');
}
