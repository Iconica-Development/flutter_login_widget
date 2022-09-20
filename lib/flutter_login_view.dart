import 'package:flutter/material.dart';
import 'package:flutter_login/backend/login_repository.dart';
import './extensions/widget.dart';
import '../default_translation.dart';
import '../plugins/login/login_email_password.dart';
import 'flutter_login_sdk.dart';
import 'login_config.dart';
import 'plugins/login/choose_login.dart';
import 'widgets/custom_navigator.dart';
export '../plugins/form/form.dart';
export '../plugins/login/email_password_form.dart';
export '../plugins/login/forgot_password_form.dart';
export '../plugins/login/login_email_password.dart';
export 'buttons.dart';
export 'login_config.dart';
export 'plugins/settings/control.dart' show Control;

class FlutterLogin extends InheritedWidget with FlutterLoginSdk {
  FlutterLogin({
    required this.config,
    required this.repository,
    required Widget child,
    required this.app,
    Key? key,
  }) : super(key: key, child: child);

  FlutterLogin.from({
    required FlutterLogin appShell,
    required Widget child,
    Key? key,
  })  : config = appShell.config,
        repository = appShell.repository,
        app = appShell.app,
        super(child: child, key: key);
  static Function(Object?) logError = (error) {};
  static Map<String, Map<String, String>> get defaultTranslations =>
      defaultTranslation;

  final ConfigData config;
  final LoginRepository repository;
  final Widget app;

  static FlutterLogin of(BuildContext context) {
    var inheritedAppshell =
        context.dependOnInheritedWidgetOfExactType<FlutterLogin>();
    if (inheritedAppshell == null) {
      throw FlutterError(
        'You are retrieving an flutter login from a context that does not contain an flutter login. Make sure you keep the flutter login in your inheritence tree',
      );
    }
    return inheritedAppshell;
  }

  @override
  bool updateShouldNotify(FlutterLogin oldWidget) => config != oldWidget.config;
}

extension AppShellRetrieval on BuildContext {
  static LoginRepository? _cachedBackend;
  FlutterLogin appShell() => FlutterLogin.of(this);
  LoginRepository appShellBackend() {
    _cachedBackend ??= appShell().repository;
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

extension AppShellTranslate on BuildContext {
  String? _getDefaultTranslation(String key, List arguments) {
    var locale = Localizations.localeOf(this);
    var code = locale.countryCode ?? 'nl';
    var translationMap = FlutterLogin.defaultTranslations[code] ??
        FlutterLogin.defaultTranslations['nl'];
    return translationMap?[key]?.toString().format(arguments);
  }

  String translate(String key,
      {String? defaultValue, List<dynamic> arguments = const []}) {
    dynamic translateFunction = appShell().config.translate;
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

class LoginMain extends StatelessWidget with NavigateWidgetMixin {
  LoginMain({
    required this.child,
    super.key,
  });
  final Widget child;

  Widget _login(context) {
    return Builder(
      builder: (context) {
        if (context.appShell().users.isLoggedIn(context)) {
          return child;
        }

        return FlutterLogin.of(context)
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
                child: child,
              )
            : EmailPasswordLogin(
                onPressedForgotPassword: FlutterLogin.of(context)
                    .config
                    .loginOptions
                    .onPressForgotPassword,
                child: child,
              );
      },
    );
  }

  @override
  CustomNavigator build(BuildContext context) => CustomNavigator(
        pageRoute: PageRoutes.materialPageRoute,
        home: _login(context),
      );
}

class AppShellException implements Exception {
  AppShellException(
    this.error, [
    this.stackTrace = StackTrace.empty,
  ]);

  /// The unhandled [error] object.
  final Object error;

  final StackTrace stackTrace;

  @override
  String toString() {
    return 'Unhandled error occurred in Appshell: $error\n'
        '$stackTrace';
  }
}
