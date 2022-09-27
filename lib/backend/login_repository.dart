import 'dart:async';
import 'package:flutter/material.dart';
import '../login_config.dart';
import '../model/login_confirmation_result.dart';
import '../model/login_user.dart';

abstract class LoginRepository {
  String loginError = '';
  String getLoginError() => loginError;
  Future<bool> login(String username, String password);
  Future sendLoginEmail(String input);

  Future<bool> forgotPassword(String email);
  Future<bool> isRegistrationRequired(LoginUser user);
  Future<void> reLogin({required VoidCallback onLoggedIn});
}

abstract class LoginRespositoryWithAnonymous extends LoginRepository {
  Future<LoginUser?> signInAnonymous();
}

abstract class LoginRespositoryWithPhoneNumber extends LoginRepository {
  Future<void> trySignInWithPhoneNumber({
    required String phoneNumber,
    void Function(
      String verificationId,
      int? resendToken,
      LoginConfirmationResult? resultWeb,
    )?
        onCodeSent,
    void Function(String errorCode)? onVerificationFailed,
  });
  Future<LoginUser?> signInWithSMSCode(
    String verificationId,
    String smsCode,
    String phoneNumber, {
    LoginConfirmationResult? resultWeb,
  });
}

abstract class LoginRepositoryWithSocial extends LoginRepository {
  Future<LoginUser?> signInWithSocial(SocialLoginBundle bundle);
}
