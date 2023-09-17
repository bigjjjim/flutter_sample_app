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
    await authProvider.signInWithGoogle();
    if (authProvider.isLoggedIn) {
      if (context.mounted) Navigator.pushReplacementNamed(context, '/');
    } else {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Failed to login with Google.')),
      );
    }
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
    await authProvider.signInWithApple();
    if (authProvider.isLoggedIn) {
      if (context.mounted) Navigator.pushReplacementNamed(context, '/');
    }
  } catch (error) {
    // Display error message to user
    scaffoldMessenger.showSnackBar(
      const SnackBar(content: Text(errorApple)),
    );
  }
}
