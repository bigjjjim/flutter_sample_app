import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../UI/styles/theme.dart';
import '../providers/auth_provider.dart';
import '../utils/app_constants.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/onboarding_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: MaterialApp(
            // adding custom theme
            theme: appTheme,
            // define routes
            routes: {
              '/login': (context) => const LoginScreen(),
              '/onboarding': (context) => const OnboardingScreen(),
              '/home': (context) => const HomeScreen(),
              // Add other routes as needed
            },
            home: const AuthWrapper()));
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    // get the initial route to be shown to users
    if (!authProvider.isInitialized) {
      return loadingWidget;
      // no onboarding for web
    } else if (authProvider.isFirstTimeUser && kIsWeb == false) {
      return const OnboardingScreen();
    } else if (!authProvider.isLoggedIn) {
      return const LoginScreen();
    } else {
      return const HomeScreen();
    }
  }
}
