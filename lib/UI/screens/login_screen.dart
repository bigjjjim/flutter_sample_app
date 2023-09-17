import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common_widgets/login_widgets.dart';
import '../../services/login_services.dart';
import '../../providers/auth_provider.dart';
import '../../utils/app_constants.dart';
import '../../utils/login_constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            titleLoginScreen,
          ),
          //remove return button
          automaticallyImplyLeading: false,
          //reduce shadow
          elevation: 1,
        ),
        // Prevents the native back button/gesture from navigating back
        body: WillPopScope(
          onWillPop: () async => false,
          //using auth consumer
          child: Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomLoginButton(
                            imagePath: "assets/login/googleIcon.png",
                            label: labelGoogleSignIn,
                            onPressed: () {
                              handleGoogleSignIn(
                                context,
                                authProvider,
                              );
                            },
                          ),
                          v16px,
                          // vertical spacing of 16 px
                          // remove apple sign in for web
                          kIsWeb
                              ? Container()
                              : CustomLoginButton(
                                  imagePath: "assets/login/apple-logo.png",
                                  label: labelAppleSignIn,
                                  onPressed: () {
                                    handleAppleSignIn(
                                      context,
                                      authProvider,
                                    );
                                  }),
                        ],
                      ),
                    ),
                  ),
                  // Loading overlay
                  if (authProvider.isLoading)
                    const Positioned.fill(
                      child: Center(child: loadingWidget),
                    ),
                ],
              );
            },
          ),
        ));
  }
}
