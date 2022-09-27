import 'dart:async';

import 'package:flutter/material.dart';

class LoginOptions {
  const LoginOptions({
    this.image,
    this.title,
    this.subtitle,
    this.emailLabel,
    this.passwordLabel,
    this.emailInputPrefix,
    this.passwordInputPrefix,
    this.decoration = const InputDecoration(),
    this.initialEmail = '',
    this.initialPassword = '',
    this.translations = const LoginTranslations(),
    this.loginButtonBuilder = _createLoginButton,
    this.forgotPasswordButtonBuilder = _createForgotPasswordButton,
    this.registrationButtonBuilder = _createRegisterButton,
  });

  final ButtonBuilder loginButtonBuilder;
  final ButtonBuilder registrationButtonBuilder;
  final ButtonBuilder forgotPasswordButtonBuilder;

  final Widget? image;
  final Widget? title;
  final Widget? subtitle;
  final Widget? emailLabel;
  final Widget? passwordLabel;
  final Widget? emailInputPrefix;
  final Widget? passwordInputPrefix;
  final InputDecoration decoration;
  final String initialEmail;
  final String initialPassword;
  final LoginTranslations translations;
}

class LoginTranslations {
  const LoginTranslations({
    this.emailEmpty = 'Email is required',
    this.passwordEmpty = 'Password is required',
    this.emailInvalid = 'Enter a valid email address',
  });

  final String emailInvalid;
  final String emailEmpty;
  final String passwordEmpty;
}

Widget _createLoginButton(
  BuildContext context,
  OptionalAsyncCallback onPressed,
  bool disabled,
) {
  return Opacity(
    opacity: disabled ? 0.5 : 1.0,
    child: ElevatedButton(
      onPressed: onPressed,
      child: const Text('Login'),
    ),
  );
}

Widget _createForgotPasswordButton(
  BuildContext context,
  OptionalAsyncCallback onPressed,
  bool disabled,
) {
  return Opacity(
    opacity: disabled ? 0.5 : 1.0,
    child: TextButton(
      onPressed: onPressed,
      child: const Text('Forgot password?'),
    ),
  );
}

Widget _createRegisterButton(
  BuildContext context,
  OptionalAsyncCallback onPressed,
  bool disabled,
) {
  return Opacity(
    opacity: disabled ? 0.5 : 1.0,
    child: TextButton(
      onPressed: onPressed,
      child: const Text('Create Account'),
    ),
  );
}

typedef ButtonBuilder = Widget Function(
  BuildContext context,
  OptionalAsyncCallback onPressed,
  bool isDisabled,
);

typedef OptionalAsyncCallback = FutureOr<void> Function();
