import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_login/src/service/login_validation.dart';
import 'package:flutter_login/src/service/validation.dart';

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
    this.validationService,
    this.loginButtonBuilder = _createLoginButton,
    this.forgotPasswordButtonBuilder = _createForgotPasswordButton,
    this.requestForgotPasswordButtonBuilder =
        _createRequestForgotPasswordButton,
    this.registrationButtonBuilder = _createRegisterButton,
    this.emailInputContainerBuilder = _createEmailInputContainer,
    this.passwordInputContainerBuilder = _createPasswordInputContainer,
    this.emailHintText,
    this.passwordHintText,
  });

  final ButtonBuilder loginButtonBuilder;
  final ButtonBuilder registrationButtonBuilder;
  final ButtonBuilder forgotPasswordButtonBuilder;
  final ButtonBuilder requestForgotPasswordButtonBuilder;
  final InputContainerBuilder emailInputContainerBuilder;
  final InputContainerBuilder passwordInputContainerBuilder;

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
  final String? emailHintText;
  final String? passwordHintText;
  final LoginTranslations translations;
  final ValidationService? validationService;

  ValidationService get validations =>
      validationService ?? LoginValidationService(this);
}

class LoginTranslations {
  const LoginTranslations({
    this.emailEmpty = 'Email is required',
    this.passwordEmpty = 'Password is required',
    this.emailInvalid = 'Enter a valid email address',
    this.loginButton = 'Login',
    this.forgotPasswordButton = 'Forgot password?',
    this.requestForgotPasswordButton = 'Send request',
    this.registrationButton = 'Create Account',
  });

  final String emailInvalid;
  final String emailEmpty;
  final String passwordEmpty;
  final String loginButton;
  final String forgotPasswordButton;
  final String requestForgotPasswordButton;
  final String registrationButton;
}

Widget _createEmailInputContainer(Widget child) => child;

Widget _createPasswordInputContainer(Widget child) => child;

Widget _createLoginButton(
  BuildContext context,
  OptionalAsyncCallback onPressed,
  bool disabled,
  OptionalAsyncCallback onDisabledPress,
  LoginTranslations translations,
) {
  return Opacity(
    opacity: disabled ? 0.5 : 1.0,
    child: ElevatedButton(
      onPressed: !disabled ? onPressed : onDisabledPress,
      child: Text(translations.loginButton),
    ),
  );
}

Widget _createForgotPasswordButton(
  BuildContext context,
  OptionalAsyncCallback onPressed,
  bool disabled,
  OptionalAsyncCallback onDisabledPress,
  LoginTranslations translations,
) {
  return Opacity(
    opacity: disabled ? 0.5 : 1.0,
    child: ElevatedButton(
      onPressed: !disabled ? onPressed : onDisabledPress,
      child: Text(translations.forgotPasswordButton),
    ),
  );
}

Widget _createRequestForgotPasswordButton(
  BuildContext context,
  OptionalAsyncCallback onPressed,
  bool disabled,
  OptionalAsyncCallback onDisabledPress,
  LoginTranslations translations,
) {
  return Opacity(
    opacity: disabled ? 0.5 : 1.0,
    child: ElevatedButton(
      onPressed: !disabled ? onPressed : onDisabledPress,
      child: Text(translations.requestForgotPasswordButton),
    ),
  );
}

Widget _createRegisterButton(
  BuildContext context,
  OptionalAsyncCallback onPressed,
  bool disabled,
  OptionalAsyncCallback onDisabledPress,
  LoginTranslations translations,
) {
  return Opacity(
    opacity: disabled ? 0.5 : 1.0,
    child: ElevatedButton(
      onPressed: !disabled ? onPressed : onDisabledPress,
      child: Text(translations.registrationButton),
    ),
  );
}

typedef ButtonBuilder = Widget Function(
  BuildContext context,
  OptionalAsyncCallback onPressed,
  bool isDisabled,
  OptionalAsyncCallback onDisabledPress,
  LoginTranslations options,
);

typedef InputContainerBuilder = Widget Function(
  Widget child,
);

typedef OptionalAsyncCallback = FutureOr<void> Function();
