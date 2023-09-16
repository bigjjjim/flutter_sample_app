import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/home_constants.dart';
import '../../providers/auth_provider.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
      return Align(
        alignment: Alignment.topRight,
        child: ElevatedButton(
          onPressed: () async {
            await authProvider.signOut();
          },
          child: const Text(labelSignOut),
        ),
      );
    });
  }
}
