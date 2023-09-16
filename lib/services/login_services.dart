import 'package:flutter/material.dart';

import '../providers/auth_provider.dart';
import '../utils/login_constants.dart';

// google sign in and redirecting
Future<void> handleGoogleSignIn(
  BuildContext context,
  AuthProvider authProvider,
) async {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  try {
    await authProvider.signInWithGoogle().then((e) {
      if (authProvider.isLoggedIn) {
        Navigator.pushReplacementNamed(context, '/');
      }
    });
  } catch (error) {
    // Display error message to user
    scaffoldMessenger.showSnackBar(
      const SnackBar(content: Text(errorGoogle)),
    );
  }
}

// google sign in and redirecting on web
Future<void> handleGoogleSignInWeb(
  BuildContext context,
  AuthProvider authProvider,
) async {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  try {
    await authProvider.signInWithGoogle().then((e) {
      if (authProvider.isLoggedIn) {
        Navigator.pushReplacementNamed(context, '/');
      }
    });
  } catch (error) {
    // Display error message to user
    scaffoldMessenger.showSnackBar(
      const SnackBar(content: Text(errorGoogle)),
    );
  }
}

// apple sign in and redirecting
Future<void> handleAppleSignIn(
    BuildContext context, AuthProvider authProvider) async {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  try {
    await authProvider.signInWithApple().then((e) {
      if (authProvider.isLoggedIn) {
        Navigator.pushReplacementNamed(context, '/');
      }
    });
  } catch (error) {
    // Display error message to user
    scaffoldMessenger.showSnackBar(
      const SnackBar(content: Text(errorApple)),
    );
  }
}
