import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_login/src/config/spacer_options.dart';
import 'package:flutter_login/src/service/login_validation.dart';
import 'package:flutter_login/src/service/validation.dart';

@immutable
class LoginOptions {
  const LoginOptions({
    this.image,
    this.title,
    this.subtitle,
    this.textFieldHeight,
    this.textFieldWidth,
    this.maxFormWidth,
    this.errorStyle = const TextStyle(
      fontSize: 12.5,
      color: Colors.red,
    ),
    this.emailTextStyle,
    this.passwordTextStyle,
    this.emailDecoration = const InputDecoration(),
    this.passwordDecoration = const InputDecoration(),
    this.initialEmail = '',
    this.initialPassword = '',
    this.spacers = const LoginSpacerOptions(),
    this.translations = const LoginTranslations(),
    this.validationService,
    this.loginButtonBuilder = _createLoginButton,
    this.forgotPasswordButtonBuilder = _createForgotPasswordButton,
    this.requestForgotPasswordButtonBuilder =
        _createRequestForgotPasswordButton,
    this.registrationButtonBuilder = _createRegisterButton,
    this.errorMessageBuilder = _errorMessageBuilder,
    this.emailInputContainerBuilder = _createEmailInputContainer,
    this.passwordInputContainerBuilder = _createPasswordInputContainer,
  });

  final ButtonBuilder loginButtonBuilder;
  final ButtonBuilder registrationButtonBuilder;
  final ButtonBuilder forgotPasswordButtonBuilder;
  final ButtonBuilder requestForgotPasswordButtonBuilder;
  final InputContainerBuilder errorMessageBuilder;
  final InputContainerBuilder emailInputContainerBuilder;
  final InputContainerBuilder passwordInputContainerBuilder;

  final Widget? image;
  final Widget? title;
  final Widget? subtitle;

  /// Option to modify the spacing between the title, subtitle, image, form, and button.
  final LoginSpacerOptions spacers;

  /// Maximum width of the form. Defaults to 400.
  final double? maxFormWidth;

  final double? textFieldHeight;
  final double? textFieldWidth;

  final InputDecoration emailDecoration;
  final InputDecoration passwordDecoration;
  final String initialEmail;
  final String initialPassword;
  final TextStyle? errorStyle;
  final TextStyle? emailTextStyle;
  final TextStyle? passwordTextStyle;
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

Widget _createEmailInputContainer(Widget child) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: child,
    );

Widget _errorMessageBuilder(Widget child) => Padding(
      padding: const EdgeInsets.only(left: 16, top: 4),
      child: child,
    );

Widget _createPasswordInputContainer(Widget child) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: child,
    );

Widget _createLoginButton(
  BuildContext context,
  OptionalAsyncCallback onPressed,
  bool disabled,
  OptionalAsyncCallback onDisabledPress,
  LoginOptions options,
) {
  return Opacity(
    opacity: disabled ? 0.5 : 1.0,
    child: ElevatedButton(
      onPressed: !disabled ? onPressed : onDisabledPress,
      child: Text(options.translations.loginButton),
    ),
  );
}

Widget _createForgotPasswordButton(
  BuildContext context,
  OptionalAsyncCallback onPressed,
  bool disabled,
  OptionalAsyncCallback onDisabledPress,
  LoginOptions options,
) {
  return Opacity(
    opacity: disabled ? 0.5 : 1.0,
    child: ElevatedButton(
      onPressed: !disabled ? onPressed : onDisabledPress,
      child: Text(options.translations.forgotPasswordButton),
    ),
  );
}

Widget _createRequestForgotPasswordButton(
  BuildContext context,
  OptionalAsyncCallback onPressed,
  bool disabled,
  OptionalAsyncCallback onDisabledPress,
  LoginOptions options,
) {
  return Opacity(
    opacity: disabled ? 0.5 : 1.0,
    child: ElevatedButton(
      onPressed: !disabled ? onPressed : onDisabledPress,
      child: Text(options.translations.requestForgotPasswordButton),
    ),
  );
}

Widget _createRegisterButton(
  BuildContext context,
  OptionalAsyncCallback onPressed,
  bool disabled,
  OptionalAsyncCallback onDisabledPress,
  LoginOptions options,
) {
  return Opacity(
    opacity: disabled ? 0.5 : 1.0,
    child: ElevatedButton(
      onPressed: !disabled ? onPressed : onDisabledPress,
      child: Text(options.translations.registrationButton),
    ),
  );
}

typedef ButtonBuilder = Widget Function(
  BuildContext context,
  OptionalAsyncCallback onPressed,
  bool isDisabled,
  OptionalAsyncCallback onDisabledPress,
  LoginOptions options,
);

typedef InputContainerBuilder = Widget Function(
  Widget child,
);

typedef OptionalAsyncCallback = FutureOr<void> Function();
