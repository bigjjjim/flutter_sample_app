import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../utils/login_constants.dart';
import '../../utils/app_constants.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            v128px, // vertical space 128px
            Text(
              welcomeTitle,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            v16px,
            Text(
              welcomeMessage,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                // Update provider that the onboarding was seen:
                await Provider.of<AuthProvider>(context, listen: false)
                    .markOnboardingComplete()
                    .then((e) {
                  Navigator.pushReplacementNamed(context, '/login');
                });
              },
              child: const Text(textButtonOnboarding),
            ),
            v128px
          ],
        ),
      ),
    );
  }
}
