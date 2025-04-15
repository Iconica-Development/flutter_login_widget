import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_login/src/config/forgot_password_spacer_options.dart";
import "package:flutter_login/src/config/spacer_options.dart";
import "package:flutter_login/src/service/login_validation.dart";
import "package:flutter_login/src/service/validation.dart";

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
      labelText: "Email address",
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
      labelText: "Password",
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
    this.initialEmail = "",
    this.initialPassword = "",
    this.spacers = const LoginSpacerOptions(
      spacerBeforeTitle: 8,
      spacerAfterTitle: 2,
      formFlexValue: 2,
    ),
    this.translations = const LoginTranslations(),
    this.accessibilityIdentifiers = const LoginAccessibilityIdentifiers.empty(),
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
      spacerAfterButton: 4,
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
    this.biometricsOptions = const LoginBiometricsOptions(),
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

  /// Accessibility identifiers for the standard widgets in the component.
  /// The inputfields and buttons have accessibility identifiers and their own
  /// container so they are visible in the accessibility tree.
  /// This is used for testing purposes.
  final LoginAccessibilityIdentifiers accessibilityIdentifiers;

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

  /// Options for enabling and customizing biometrics login
  final LoginBiometricsOptions biometricsOptions;
}

class LoginBiometricsOptions {
  const LoginBiometricsOptions({
    this.loginWithBiometrics = false,
    this.triggerBiometricsAutomatically = false,
    this.allowBiometricsAlternative = true,
    this.onBiometricsSuccess,
    this.onBiometricsError,
    this.onBiometricsFail,
  });

  /// Ask the user to login with biometrics instead of email and password.
  final bool loginWithBiometrics;

  /// Allow the user to login with biometrics even if they have no biometrics
  /// set up on their device. This will use their device native login methods.
  final bool allowBiometricsAlternative;

  /// Automatically open the native biometrics UI instead of waiting for the
  /// user to press the biometrics button
  final bool triggerBiometricsAutomatically;

  /// The callback function to be called when the biometrics login is
  /// successful.
  final OptionalAsyncCallback? onBiometricsSuccess;

  /// The callback function to be called when the biometrics login fails.
  final OptionalAsyncCallback? onBiometricsFail;

  /// The callback function to be called when the biometrics login errors.
  final OptionalAsyncCallback? onBiometricsError;
}

/// Translations for all the texts in the component
class LoginTranslations {
  /// Provide your own translations to override the default english translations
  const LoginTranslations({
    this.emailEmpty = "Please enter your email address",
    this.passwordEmpty = "Please enter your password",
    this.emailInvalid = "Please enter a valid email address",
    this.loginButton = "Log in",
    this.forgotPasswordButton = "Forgot password?",
    this.requestForgotPasswordButton = "Send link",
    this.registrationButton = "Create account",
    this.biometricsLoginMessage = "Log in with biometrics",
  });

  final String emailInvalid;
  final String emailEmpty;
  final String passwordEmpty;
  final String loginButton;
  final String forgotPasswordButton;
  final String requestForgotPasswordButton;
  final String registrationButton;
  final String biometricsLoginMessage;
}

/// Accessibility identifiers for the standard widgets in the component.
class LoginAccessibilityIdentifiers {
  /// Default [LoginAccessibilityIdentifiers] constructor where all the
  /// identifiers are required. This is to ensure that apps automatically break
  /// when new identifiers are added.
  const LoginAccessibilityIdentifiers({
    required this.emailTextFieldIdentifier,
    required this.passwordTextFieldIdentifier,
    required this.loginButtonIdentifier,
    required this.forgotPasswordButtonIdentifier,
    required this.requestForgotPasswordButtonIdentifier,
    required this.registrationButtonIdentifier,
  });

  /// Empty [LoginAccessibilityIdentifiers] constructor where all the
  /// identifiers are already set to their default values. You can override all
  /// or some of the default values.
  const LoginAccessibilityIdentifiers.empty({
    this.emailTextFieldIdentifier = "email_text_field",
    this.passwordTextFieldIdentifier = "password_text_field",
    this.loginButtonIdentifier = "login_button",
    this.forgotPasswordButtonIdentifier = "forgot_password_button",
    this.requestForgotPasswordButtonIdentifier =
        "request_forgot_password_button",
    this.registrationButtonIdentifier = "registration_button",
  });

  /// Identifier for the email text field.
  final String emailTextFieldIdentifier;

  /// Identifier for the password text field.
  final String passwordTextFieldIdentifier;

  /// Identifier for the login button.
  final String loginButtonIdentifier;

  /// Identifier for the forgot password button.
  final String forgotPasswordButtonIdentifier;

  /// Identifier for the request forgot password button.
  final String requestForgotPasswordButtonIdentifier;

  /// Identifier for the registration button.
  final String registrationButtonIdentifier;
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
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FilledButton(
                onPressed: () async =>
                    !disabled ? await onPressed() : await onDisabledPress(),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    options.translations.loginButton,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ),
            ),
          ),
        ],
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
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
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
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                decoration: TextDecoration.underline,
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
