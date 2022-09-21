import 'dart:async';
import 'package:flutter/material.dart';
import '../login_config.dart';
import '../model/login_confirmation_result.dart';
import '../model/login_user.dart';

abstract class LoginRepository {
  bool loggedIn = false;
  String loginError = '';

  String getLoginError() => loginError;
  Future<bool> login(String username, String password);
  Future<LoginUser?> signInWithSocial(SocialLoginBundle bundle);
  Future<bool?> userprofileExists();
  Future sendLoginEmail(String input);
  Future<void> trySignInWithPhoneNumber({
    required String phoneNumber,
    void Function(
      String verificationId,
      int? resendToken,
      LoginConfirmationResult? resultWeb,
    )?
        onCodeSent,
    void Function(String errorCode)? onVerificationFailed,
    void Function(LoginUser? user)? onAutoLogin,
  });
  Future<LoginUser?> signInWithSMSCode(
    String verificationId,
    String smsCode,
    String phoneNumber, {
    LoginConfirmationResult? resultWeb,
  });
  Future<bool> forgotPassword(String email);
  Future<bool> isRegistrationRequired(LoginUser user);
  Future<void> reLogin({required VoidCallback onLoggedIn});
  Future<LoginUser?> signInAnonymous();
}
