import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// this provider provides user logging status and related services
class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // initialise the values to be checked anywhere in app
  User? _user;
  User? get user => _user;

  bool get isLoggedIn => _user != null;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  bool? _isFirstTimeUser;
  bool get isFirstTimeUser => _isFirstTimeUser ?? true;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //construct user and bool first time values
  AuthProvider() {
    _user = _firebaseAuth.currentUser;
    _checkIfFirstTimeUser();
  }

  void _startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void _stopLoading({String? errorMessage}) {
    _isLoading = false;
    _errorMessage = errorMessage;
    notifyListeners();
  }

  // Google Sign-In
  Future<void> signInWithGoogle() async {
    _startLoading();
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential authResult =
            await _firebaseAuth.signInWithCredential(credential);
        _user = authResult.user;
      }
      _stopLoading();
    } catch (error) {
      // print(error);
      _stopLoading(errorMessage: 'Failed to sign in with Google.');
      rethrow;
    }
  }

  // Google Sign-In for web
  Future<void> signInWithGoogleForWeb() async {
    _startLoading();
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signInSilently();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential authResult =
            await _firebaseAuth.signInWithCredential(credential);
        _user = authResult.user;
      }
      _stopLoading();
    } catch (error) {
      // print(error);
      _stopLoading(errorMessage: 'Failed to sign in with Google.');
      rethrow;
    }
  }

  // Apple Sign-In
  Future<void> signInWithApple() async {
    _startLoading();
    try {
      if (!await SignInWithApple.isAvailable()) {
        throw PlatformException(
          code: 'APPLE_SIGN_IN_NOT_AVAILABLE',
          message: 'Apple SignIn is not available on this device.',
        );
      }

      final appleSignInResult = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final AuthCredential credential = OAuthProvider('apple.com').credential(
        idToken: appleSignInResult.identityToken,
        accessToken: appleSignInResult.authorizationCode,
      );

      final UserCredential authResult =
          await _firebaseAuth.signInWithCredential(credential);
      _user = authResult.user;

      _stopLoading();
    } catch (error) {
      // print(error);
      _stopLoading(errorMessage: 'Failed to sign in with Apple.');
      rethrow;
    }
  }

  Future<void> signOut() async {
    _startLoading();
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      _user = null;
      _stopLoading();
    } catch (error) {
      // print(error);
      _stopLoading(errorMessage: 'Failed to sign out.');
      rethrow;
    }
  }

//methods for onboarding logic
  static const String _onboardingCompleteKey = 'onboardingComplete';

  Future<bool> get hasCompletedOnboarding async {
    // print("running hascompletedOnboarding");
    final prefs = await SharedPreferences.getInstance();
    final isCompleted = prefs.getBool(_onboardingCompleteKey) ?? false;
    return isCompleted;
  }

  Future<void> markOnboardingComplete() async {
    // print("running makeOnboarding");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompleteKey, true);
  }

  _checkIfFirstTimeUser() async {
    try {
      _isFirstTimeUser = !(await hasCompletedOnboarding);
      // use this line to check onboarding screen
      // _isFirstTimeUser = await hasCompletedOnboarding;
    } catch (e) {
      print("Error checking if first-time user: $e");
    } finally {
      _isInitialized = true;
      notifyListeners();
    }
  }
}
