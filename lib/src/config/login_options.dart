import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_login/src/config/forgot_password_spacer_options.dart';
import 'package:flutter_login/src/config/spacer_options.dart';
import 'package:flutter_login/src/service/login_validation.dart';
import 'package:flutter_login/src/service/validation.dart';

@immutable
class LoginOptions {
  const LoginOptions({
    this.image,
    this.title,
    this.subtitle,
    this.maxFormWidth,
    this.emailTextStyle,
    this.passwordTextStyle,
    this.emailTextAlign,
    this.passwordTextAlign,
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
    this.emailInputContainerBuilder = _createEmailInputContainer,
    this.passwordInputContainerBuilder = _createPasswordInputContainer,
    this.showObscurePassword = true,
    this.forgotPasswordSpacerOptions = const ForgotPasswordSpacerOptions(),
  });

  factory LoginOptions.defaults() => const LoginOptions(
        emailDecoration: InputDecoration(
          labelText: 'Email',
          hintText: 'Enter your email',
        ),
        passwordDecoration: InputDecoration(
          labelText: 'Password',
          hintText: 'Enter your password',
        ),
      );

  /// Builds the login button.
  final ButtonBuilder loginButtonBuilder;

  /// Builds the registration button.
  final ButtonBuilder registrationButtonBuilder;

  /// Builds the forgot password button.
  final ButtonBuilder forgotPasswordButtonBuilder;

  /// Builds the request forgot password button.
  final ButtonBuilder requestForgotPasswordButtonBuilder;

  /// Builds the email input container.
  final InputContainerBuilder emailInputContainerBuilder;

  /// Builds the password input container.
  final InputContainerBuilder passwordInputContainerBuilder;

  /// The image to display on the login screen.
  final Widget? image;

  /// The title widget to display on the login screen.
  final Widget? title;

  /// The subtitle widget to display on the login screen.
  final Widget? subtitle;

  /// Option to modify the spacing between the title, subtitle, image, form,
  /// and button.
  final LoginSpacerOptions spacers;

  /// Option to modify the spacing between the items on the forgotPasswordForm.
  final ForgotPasswordSpacerOptions forgotPasswordSpacerOptions;

  /// Maximum width of the form. Defaults to 400.
  final double? maxFormWidth;

  /// Decoration for the email input field.
  final InputDecoration emailDecoration;

  /// Decoration for the password input field.
  final InputDecoration passwordDecoration;

  /// The initial email value for the email input field.
  final String initialEmail;

  /// The initial password value for the password input field.
  final String initialPassword;

  /// The text style for the email input field.
  final TextStyle? emailTextStyle;

  /// The text style for the password input field.
  final TextStyle? passwordTextStyle;

  /// The text alignment for the email input field.
  final TextAlign? emailTextAlign;

  /// The text alignment for the password input field.
  final TextAlign? passwordTextAlign;

  /// Translations for various texts on the login screen.
  final LoginTranslations translations;

  /// The validation service used for validating email and password inputs.
  final ValidationService? validationService;

  /// Determines whether the password field should be obscured.
  final bool showObscurePassword;

  /// Get validations.
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
      padding: const EdgeInsets.only(bottom: 15),
      child: child,
    );

Widget _createPasswordInputContainer(Widget child) => child;

Widget _createLoginButton(
  BuildContext context,
  OptionalAsyncCallback onPressed,
  bool disabled,
  OptionalAsyncCallback onDisabledPress,
  LoginOptions options,
) =>
    Opacity(
      opacity: disabled ? 0.5 : 1.0,
      child: ElevatedButton(
        onPressed: !disabled ? onPressed : onDisabledPress,
        child: Text(options.translations.loginButton),
      ),
    );

Widget _createForgotPasswordButton(
  BuildContext context,
  OptionalAsyncCallback onPressed,
  bool disabled,
  OptionalAsyncCallback onDisabledPress,
  LoginOptions options,
) =>
    Opacity(
      opacity: disabled ? 0.5 : 1.0,
      child: ElevatedButton(
        onPressed: !disabled ? onPressed : onDisabledPress,
        child: Text(options.translations.forgotPasswordButton),
      ),
    );

Widget _createRequestForgotPasswordButton(
  BuildContext context,
  OptionalAsyncCallback onPressed,
  bool disabled,
  OptionalAsyncCallback onDisabledPress,
  LoginOptions options,
) =>
    Opacity(
      opacity: disabled ? 0.5 : 1.0,
      child: ElevatedButton(
        onPressed: !disabled ? onPressed : onDisabledPress,
        child: Text(options.translations.requestForgotPasswordButton),
      ),
    );

Widget _createRegisterButton(
  BuildContext context,
  OptionalAsyncCallback onPressed,
  bool disabled,
  OptionalAsyncCallback onDisabledPress,
  LoginOptions options,
) =>
    Opacity(
      opacity: disabled ? 0.5 : 1.0,
      child: ElevatedButton(
        onPressed: !disabled ? onPressed : onDisabledPress,
        child: Text(options.translations.registrationButton),
      ),
    );

typedef ButtonBuilder = Widget Function(
  BuildContext context,
  OptionalAsyncCallback onPressed,
  // ignore: avoid_positional_boolean_parameters
  bool isDisabled,
  OptionalAsyncCallback onDisabledPress,
  LoginOptions options,
);

typedef InputContainerBuilder = Widget Function(
  Widget child,
);

typedef OptionalAsyncCallback = FutureOr<void> Function();
