import 'dart:async';
import 'package:flutter/foundation.dart';
import '../login_config.dart';
import '../model/confirmation_result.dart';
import '../model/user.dart';

abstract class LoginRepository with ChangeNotifier {
  String? _loggedIn = '';
  String loginError = '';
  bool _initialized = false;

  bool isInitialized() => _initialized;

  /// This function returns true if the user is logged in.
  bool isLoggedIn() => _loggedIn != null && _loggedIn != '';
  String get user => _loggedIn!;

  /// This function sets the logged in user.
  void setLoggedIn(String user) => _loggedIn = user;

  String getLoginError() => loginError;

  Future<bool> login(String username, String password);

  Future<void> logout() async {
    _loggedIn = null;
  }

  /// This function returns a map with the username.
  Map<String, dynamic> getUser() => {
        'username': _loggedIn,
      };

  @mustCallSuper
  Future<void> init() async {
    // Auto login here
    _initialized = true;
  }

  Future<User?> signInWithSocial(SocialLoginBundle bundle);
  Future<bool?> userprofileExists();
  Future sendLoginEmail(String input);
  Future<void> trySignInWithPhoneNumber({
    required String phoneNumber,
    void Function(
      String verificationId,
      int? resendToken,
      ConfirmationResult? resultWeb,
    )?
        onCodeSent,
    void Function(String errorCode)? onVerificationFailed,
    void Function(User? user)? onAutoLogin,
  });
  Future<User?> signInWithSMSCode(
    String verificationId,
    String smsCode,
    String phoneNumber, {
    ConfirmationResult? resultWeb,
  });
  Future<bool> forgotPassword(String email);
  Future<bool> isRegistrationRequired(User user);
  Future<void> reLogin();
  Future<User?> signInAnonymous();
}
