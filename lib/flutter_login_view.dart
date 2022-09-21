import 'package:flutter/material.dart';
import 'package:flutter_login/backend/login_repository.dart';
import '../default_translation.dart';
import '../plugins/login/login_email_password.dart';
import 'login_config.dart';
import 'plugins/login/choose_login.dart';
export '../plugins/form/form.dart';
export '../plugins/login/email_password_form.dart';
export '../plugins/login/login_email_password.dart';
export 'buttons.dart';
export 'login_config.dart';
export 'model/login_confirmation_result.dart';
export 'model/login_user.dart';
export 'plugins/settings/control.dart' show Control;

class FlutterLogin extends InheritedWidget {
  const FlutterLogin({
    required this.config,
    required this.repository,
    required Widget child,
    required this.app,
    Key? key,
  }) : super(key: key, child: child);

  static Function(Object?) logError = (error) {};
  static Map<String, Map<String, String>> get defaultTranslations =>
      defaultTranslation;

  final ConfigData config;
  final LoginRepository repository;
  final Widget app;

  static FlutterLogin of(BuildContext context) {
    var inheritedLogin =
        context.dependOnInheritedWidgetOfExactType<FlutterLogin>();
    if (inheritedLogin == null) {
      throw FlutterError(
        'You are retrieving an flutter login from a context that does not contain an flutter login. Make sure you keep the flutter login in your inheritence tree',
      );
    }
    return inheritedLogin;
  }

  @override
  bool updateShouldNotify(FlutterLogin oldWidget) => config != oldWidget.config;
}

extension LoginRetrieval on BuildContext {
  static LoginRepository? _cachedBackend;
  FlutterLogin login() => FlutterLogin.of(this);
  LoginRepository loginRepository() {
    _cachedBackend ??= login().repository;
    return _cachedBackend!;
  }
}

extension StringFormat on String {
  String _interpolate(String string, List<dynamic> params) {
    var result = string;
    for (var i = 1; i < params.length + 1; i++) {
      result = result.replaceAll('%$i\$', params[i - 1]?.toString() ?? '');
    }

    return result;
  }

  String format(List<dynamic> params) => _interpolate(this, params);
}

extension LoginTranslate on BuildContext {
  String? _getDefaultTranslation(String key, List arguments) {
    var locale = Localizations.localeOf(this);
    var code = locale.countryCode ?? 'nl';
    var translationMap = FlutterLogin.defaultTranslations[code] ??
        FlutterLogin.defaultTranslations['nl'];
    return translationMap?[key]?.toString().format(arguments);
  }

  String translate(
    String key, {
    String? defaultValue,
    List<dynamic> arguments = const [],
  }) {
    dynamic translateFunction = login().config.translate;
    if (translateFunction == null) {
      return _getDefaultTranslation(key, arguments) ?? defaultValue ?? key;
    }
    return translateFunction(
      this,
      key,
      defaultvalue: defaultValue,
    );
  }
}

class LoginMain extends StatefulWidget {
  const LoginMain({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  State<LoginMain> createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  bool _checkedIfLoggedIn = false;
  bool _isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    if (!_checkedIfLoggedIn) {
      context.loginRepository().reLogin(
            onLoggedIn: () => setState(
              () {
                _isLoggedIn = true;
              },
            ),
          );

      _checkedIfLoggedIn = true;
    }

    return _isLoggedIn
        ? widget.child
        : Builder(
            builder: (context) => FlutterLogin.of(context)
                        .config
                        .loginOptions
                        .loginMethod
                        .contains(LoginMethod.LoginInteractiveWithSocial) ||
                    FlutterLogin.of(context)
                        .config
                        .loginOptions
                        .loginMethod
                        .contains(LoginMethod.LoginInteractiveWithPhoneNumber)
                ? ChooseLogin(
                    child: widget.child,
                  )
                : EmailPasswordLogin(
                    onPressedForgotPassword: FlutterLogin.of(context)
                        .config
                        .loginOptions
                        .onPressForgotPassword,
                    child: widget.child,
                  ),
          );
  }
}

class LoginException implements Exception {
  LoginException(
    this.error, [
    this.stackTrace = StackTrace.empty,
  ]);

  /// The unhandled [error] object.
  final Object error;

  final StackTrace stackTrace;

  @override
  String toString() {
    return 'Unhandled error occurred in login: $error\n'
        '$stackTrace';
  }
}
