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
    this.maxFormWidth,
    this.emailTextStyle,
    this.passwordTextStyle,
    this.emailTextAlign,
    this.passwordTextAlign,
    this.emailDecoration = const InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      labelText: 'Email address',
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff71C6D1),
        ),
      ),
      labelStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
    ),
    this.passwordDecoration = const InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      labelText: 'Password',
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff71C6D1),
        ),
      ),
      labelStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
    ),
    this.initialEmail = '',
    this.initialPassword = '',
    this.spacers = const LoginSpacerOptions(
      spacerBeforeTitle: 8,
      spacerAfterTitle: 2,
      formFlexValue: 2,
    ),
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
    this.forgotPasswordSpacerOptions = const ForgotPasswordSpacerOptions(
      spacerAfterButton: 3,
      spacerBeforeTitle: 1,
    ),
    this.loginBackgroundColor = const Color(0xffFAF9F6),
    this.forgotPasswordBackgroundColor = const Color(0xffFAF9F6),
    this.forgotPasswordScreenPadding = const Padding(
      padding: EdgeInsets.symmetric(horizontal: 60),
    ),
    this.forgotPasswordCustomAppBar,
    this.suffixIconSize,
    this.suffixIconPadding,
  });

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
  final double? suffixIconSize;
  final EdgeInsets? suffixIconPadding;

  /// Get validations.
  ValidationService get validations =>
      validationService ?? LoginValidationService(this);

  /// The background color for the login screen.
  final Color loginBackgroundColor;

  /// The background color for the forgot password screen.
  final Color forgotPasswordBackgroundColor;

  /// The padding for the forgot password screen.
  final Padding forgotPasswordScreenPadding;

  /// forgot password custom AppBar
  final AppBar? forgotPasswordCustomAppBar;
}

class LoginTranslations {
  const LoginTranslations({
    this.emailEmpty = 'Email is required',
    this.passwordEmpty = 'Password is required',
    this.emailInvalid = 'Enter a valid email address',
    this.loginButton = 'Login',
    this.forgotPasswordButton = 'Forgot password?',
    this.requestForgotPasswordButton = 'Send link',
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
      child: InkWell(
        onTap: () async =>
            !disabled ? await onPressed() : await onDisabledPress(),
        child: Container(
          height: 44,
          width: 254,
          decoration: const BoxDecoration(
            color: Color(0xff71C6D1),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
            child: Text(
              options.translations.loginButton,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
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
      child: TextButton(
        onPressed: !disabled ? onPressed : onDisabledPress,
        child: Text(
          options.translations.forgotPasswordButton,
          style: const TextStyle(
            decoration: TextDecoration.underline,
            decorationColor: Color(0xff8D8D8D),
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xff8D8D8D),
          ),
        ),
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
      child: InkWell(
        onTap: !disabled ? onPressed : onDisabledPress,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xff71C6D1),
          ),
          height: 44,
          width: 254,
          child: Center(
            child: Text(
              options.translations.requestForgotPasswordButton,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
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
      child: TextButton(
        onPressed: !disabled ? onPressed : onDisabledPress,
        child: Text(
          options.translations.registrationButton,
          style: const TextStyle(
            decoration: TextDecoration.underline,
            decorationColor: Color(0xff71C6D1),
            color: Color(0xff71C6D1),
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
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
