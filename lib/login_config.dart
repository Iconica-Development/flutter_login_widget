import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/widgets/custom_navigator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'backend/login_repository.dart';
import 'default_theme.dart';
import 'extensions/widget.dart';
import 'flutter_login_view.dart';

enum RegistrationMode {
  Enabled,
  Disabled,
}

enum LoginMode {
  LoginRequired,
  LoginOptional,
  LoginAutomatic,
  NoLogin,
  LoginAnonymous
}

enum LoginMethod {
  LoginInteractiveWithUsernameAndPassword,
  LoginInteractiveWithMagicLink,
  LoginInteractiveWithSocial,
  LoginInteractiveWithPhoneNumber,
}

enum AutoLoginMode {
  alwaysOn,
  alwaysOff,
  defaultOn,
  defaultOff,
}

enum SocialLoginMethod {
  FaceBook,
  Google,
  Apple,
  Twitter,
  LinkedIn,
  Microsoft,
  Custom
}

enum SocialInteractionType {
  Login,
  Register,
}

class SocialLoginBundle {
  SocialLoginBundle({this.method, this.interactionType});
  SocialLoginMethod? method;
  SocialInteractionType? interactionType;
}

class IconLibrary {
  const IconLibrary({
    this.facebook = FontAwesomeIcons.facebook,
    this.google = FontAwesomeIcons.google,
    this.apple = FontAwesomeIcons.apple,
    this.linkedIn = FontAwesomeIcons.linkedin,
    this.twitter = FontAwesomeIcons.twitter,
    this.microsoft = FontAwesomeIcons.microsoft,
    this.customSocial = Icons.help_center_outlined,
    this.passwordVisible = Icons.visibility,
    this.passwordHidden = Icons.visibility_off,
    this.dateTimePicker = Icons.calendar_today,
    this.backButton = Icons.arrow_back,
    this.forgotPasswordMail = Icons.mail,
    this.magicLinkAwaitEmail = Icons.account_balance,
    this.changePasswordSuccessful = Icons.check,
    this.alertDialogClose = Icons.close,
  });

  final IconData facebook;
  final IconData google;
  final IconData apple;
  final IconData linkedIn;
  final IconData twitter;
  final IconData microsoft;
  final IconData customSocial;
  final IconData passwordVisible;
  final IconData passwordHidden;
  final IconData dateTimePicker;
  final IconData backButton;
  final IconData forgotPasswordMail;
  final IconData magicLinkAwaitEmail;
  final IconData changePasswordSuccessful;
  final IconData alertDialogClose;
}

typedef SocialLoginListener = Future Function(SocialLoginBundle bundle);

class ConfigData {
  ConfigData({
    this.loginOptions = const LoginOptions(),
    this.registrationOptions = const RegistrationOptions(),
    this.connectionOptions = const ConnectionOptions(),
    this.appTheme = const AppTheme(),
    this.appOptions = const AppOptions(),
    this.translate,
  });

  factory ConfigData.example() {
    return ConfigData(
      loginOptions: const LoginOptions(
        loginImage: 'assets/images/welkom.png;appshell',
        loginMode: LoginMode.LoginOptional,
        loginMethod: [
          LoginMethod.LoginInteractiveWithUsernameAndPassword,
        ],
      ),
      registrationOptions: const RegistrationOptions(
        registrationMode: RegistrationMode.Enabled,
      ),
    );
  }

  /// Provide a translate function for adding or changing the translations used in the appshell.
  /// The default translations of the appshell are obtainable trough [AppShell.defaultTranslations].
  final String Function(
    BuildContext context,
    String text, {
    String? defaultvalue,
  })? translate;

  final LoginOptions loginOptions;
  final RegistrationOptions registrationOptions;
  final ConnectionOptions connectionOptions;
  final AppTheme appTheme;
  final AppOptions appOptions;

  static bool useTimeFormatBasedOnLocale() {
    var defaultLocale =
        Locale.fromSubtags(languageCode: Intl.shortLocale(Intl.systemLocale));
    switch (defaultLocale.countryCode) {
      case 'NL':
        return true;
      case 'US':
        return false;
      default:
        return true;
    }
  }
}

class LoginOptions {
  const LoginOptions({
    this.autoLoginMode = AutoLoginMode.defaultOn,
    this.loginImage = '',
    this.loginEmail,
    this.loginPassword,
    this.loginMethod = const [],
    this.backgroundImage,
    this.socialOptions = const SocialOptions(
      socialLogins: [],
      socialLoginListener: SocialOptions.unimplementedLoginListener,
    ),
    this.loginMode = LoginMode.NoLogin,
    this.onPressRegister,
    this.onPressForgotPassword,
  });

  /// The mode determining the login actions required to use the app.
  ///
  /// [LoginMode.LoginAutomatic] Will automatically log in with [loginAccount]
  /// [loginPassword].
  ///
  /// [LoginMode.LoginOptional] Will allow the user to log in from the settings
  /// screens, app menu or from any other [MenuAction.profile()] widget.
  ///
  /// [LoginMode.LoginRequired] Is to require all users to first log in before
  /// continuing to use the app.
  /// [LoginMode.LoginAnonymous] Will automatically log in anonymous.
  final LoginMode loginMode;

  /// A list of possible login methods.
  ///
  /// [LoginMethod.LoginInteractiveWithMagicLink]
  /// The user can login by clicking a link in an email send by the appshell to the by the user provided email address.
  ///
  /// [LoginMethod.LoginInteractiveWithSocial]
  /// The user can login using one of the social media accounts that is supported.
  /// Add a social login method by adding a [SocialLoginMethod] to [socialLogins],
  /// and implementing the social login handler for the added [SocialLoginMethod] using [socialLoginListener]
  ///
  /// [LoginMethod.LoginInteractiveWithUsernameAndPassword]
  /// The user can login using a email address and password.
  ///
  /// [LoginMethod.LoginInteractiveWithPhoneNumber]
  /// After the user entered a phone number, the user can sign in with a code send by sms.
  final List<LoginMethod> loginMethod;

  /// The email used to login with [LoginMode.LoginAutomatic]
  final String? loginEmail;

  /// The password used to login with [LoginMode.LoginAutomatic]
  final String? loginPassword;

  /// String path of the asset containing the login image
  final String loginImage;

  final SocialOptions socialOptions;

  /// The image used as background for all login related screens
  ///
  /// If you want to change the registration background image, view [RegistrationOptions.backgroundImage]
  final String? backgroundImage;

  /// [AutoLoginMode.defaultOn]
  /// Auto login can be enabled/disabled using a checkbox on the login screen.
  /// auto login is enabled by default.
  /// [AutoLoginMode.defaultOff]
  /// Auto login can be enabled/disabled using a checkbox on the login screen.
  /// auto login is disabled by default.
  /// [AutoLoginMode.alwaysOn]
  /// Auto login is always on, there is no way to disable it.
  /// [AutoLoginMode.alwaysOff]
  /// Auto login is always off, there is no way to enable it.
  final AutoLoginMode autoLoginMode;

  final VoidCallback? onPressForgotPassword;

  final VoidCallback? onPressRegister;
}

class SocialOptions {
  const SocialOptions({
    required this.socialLogins,
    required this.socialLoginListener,
    this.forceAppleSignin = true,
  });

  /// A list of SocialLogins, like Facebook, google.
  /// See [SocialLoginMethod] for more information. If any
  /// method is provided, [SocialLoginMethod.Apple] is added on iOS devices.
  final List<SocialLoginMethod> socialLogins;

  /// Provide a function to handle sign in for social media accounts which returns the user credentials.
  /// A [SocialLoginBundle] parameter is passed to determine which social login method is requested.
  ///
  /// Example:
  ///
  /// ```
  /// socialLoginListener: (SocialLoginBundle bundle) async {
  ///   AuthCredential? credential;
  ///   switch (bundle.method) {
  ///     case SocialLoginMethod.FaceBook:
  ///       credential = await signInWithFacebook();
  ///       break;
  ///     case SocialLoginMethod.Google:
  ///       credential = await signInWithGoogle();
  ///       break;
  ///     default:
  ///       throw 'Social login received with `${bundle.method}` but was not implemented!';
  ///   }
  /// }
  /// ```
  final SocialLoginListener socialLoginListener;

  /// Stop the appshell from forcing Apple sign in on iOS devices when
  /// [socialLogins] has at least one value.
  final bool forceAppleSignin;

  static Future unimplementedLoginListener(SocialLoginBundle bundle) async =>
      throw UnimplementedError(
          'Attempt to use social logins using ${bundle.method.toString()}, but no implementation was given for social logins!');
}

class AppTheme {
  const AppTheme({
    this.icons = const IconLibrary(),
    this.inputs = const AppShellInputLibrary(),
    this.buttons = const AppShellDefaultButtons(),
  });

  /// Provide a [IconLibrary] to change the icons that are used in the appshell.
  final IconLibrary icons;

  /// Provide an instance of a class based on [InputLibrary].
  /// Override the functions to change the input fields used in the appshell.
  final InputLibrary inputs;

  /// Provide an instance of a class based on [AppButtons].
  /// Override the functions to change the buttons used in the appshell.
  final AppButtons buttons;
}

class AppOptions {
  const AppOptions({
    this.backgroundImage = '',
  });

  /// will replace the background of all appshell screens with the provided image.
  ///
  final String backgroundImage;
}

class RegistrationOptions {
  const RegistrationOptions({
    this.registrationMode = RegistrationMode.Disabled,
  });

  /// Used to determine if users can register an account.
  /// [RegistrationMode.Enabled] Users can register an account using email and password or via social login.
  /// [RegistrationMode.Disabled] Users cannot register.
  final RegistrationMode registrationMode;
}

class ConnectionOptions {
  const ConnectionOptions({
    this.connectionSettings,
    this.cloudFunctionsUrl,
  });
  final Map? connectionSettings;
  final String? cloudFunctionsUrl;
}

class LoginConfig extends StatefulWidget {
  const LoginConfig({
    required this.child,
    this.config,
    this.repository,
    Key? key,
  }) : super(key: key);
  final ConfigData? config;
  final LoginRepository? repository;
  final Widget child;

  @override
  State<LoginConfig> createState() => LoginConfigState();
}

class LoginConfigState extends State<LoginConfig> with WidgetsBindingObserver {
  FlutterLogin? login;
  late final ConfigData configData;
  late LoginRepository repository;

  @override
  void initState() {
    super.initState();
    configData = widget.config ?? ConfigData.example();

    checkForcedAppleLogin();

    checkSocialLoginOptions();

    if (widget.repository != null) {
      repository = widget.repository!;
    }

    WidgetsBinding.instance.addObserver(this);
  }

  void checkForcedAppleLogin() {
    if (!kIsWeb &&
        Platform.isIOS &&
        configData.loginOptions.loginMethod.contains(
          LoginMethod.LoginInteractiveWithSocial,
        ) &&
        configData.loginOptions.socialOptions.forceAppleSignin) {
      configData.loginOptions.socialOptions.socialLogins.add(
        SocialLoginMethod.Apple,
      );
    }
  }

  /// check for empty social logins
  ///
  /// If the config has no socialLogins and [LoginInteractiveWithSocial] is enabled an exception is thrown
  /// for apple devices an extra check is done to see if the applesignin is turned off
  void checkSocialLoginOptions() {
    if (configData.loginOptions.loginMethod
            .contains(LoginMethod.LoginInteractiveWithSocial) &&
        (kIsWeb ||
            (!Platform.isIOS ||
                !configData.loginOptions.socialOptions.forceAppleSignin))) {
      // check if apple login is removed by developer
      if (configData.loginOptions.socialOptions.socialLogins.isEmpty) {
        throw LoginException(
            'If you enable LoginMethod.LoginInteractiveWithSocial you must provide atleast 1 social login option!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    login = FlutterLogin(
      config: widget.config ?? ConfigData.example(),
      repository: repository,
      app: widget.child,
      child: CustomNavigator(
        pageRoute: PageRoutes.materialPageRoute,
        home: LoginMain(
          child: widget.child,
        ),
      ),
    );

    if (isFlutterDefaultTheme(context)) {
      return Theme(
        data: defaultTheme,
        child: login!,
      );
    }

    return login!;
  }
}
