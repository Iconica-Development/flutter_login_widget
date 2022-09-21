import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../form/fields/obscure_text_input_field.dart';
import 'forgot_password.dart';
import 'login_await_email.dart';
import 'login_image.dart';
import 'login_widget.dart';

class EmailPasswordLogin extends Login {
  const EmailPasswordLogin({
    super.key,
    Widget? child,
    this.emailsave = '',
    this.passwordsave = '',
    bool allowExit = false,
    this.onPressedForgotPassword,
  }) : super(child: child, allowExit: allowExit);

  static String? finalEmail;
  static String? finalPassword;
  final String? emailsave;
  final String? passwordsave;
  final void Function()? onPressedForgotPassword;

  @override
  EmailLoginState createState() => EmailLoginState();
}

class EmailLoginState extends LoginState<EmailPasswordLogin> {
  String email = '';
  String error = '';
  String password = '';
  bool? autoLogin;
  late SharedPreferences prefs;
  bool passwordLess = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    EmailPasswordLogin.finalEmail = widget.emailsave;
    email = widget.emailsave ?? '';
    EmailPasswordLogin.finalPassword = widget.passwordsave;
    password = widget.passwordsave ?? '';

    () async {
      prefs = await SharedPreferences.getInstance();
    }();
  }

  void onEmailChanged(String email) {
    setState(() {
      this.email = email;
      EmailPasswordLogin.finalEmail = email;
    });
  }

  void onPasswordChanged(String password) {
    setState(() {
      this.password = password;
      EmailPasswordLogin.finalPassword = password;
    });
  }

  Future<void> _handleLoginPress() async {
    setState(() {
      _loading = true;
    });

    await prefs.setBool(
      'autoLogin',
      context.login().config.loginOptions.autoLoginMode ==
          AutoLoginMode.defaultOn,
    );

    if (!passwordLess &&
        (EmailPasswordLogin.finalEmail != null) &&
        (EmailPasswordLogin.finalPassword != null)) {
      if (!(await context.loginRepository().login(
            EmailPasswordLogin.finalEmail!,
            EmailPasswordLogin.finalPassword!,
          ))) {
        setState(() {
          error = context.loginRepository().getLoginError();
          _loading = false;
        });
      } else {
        context.loginRepository().loggedIn = true;
        navigateFadeToReplace(
          context,
          (context) => widget.child,
          popRemaining: true,
        );
      }
    } else if (passwordLess && (EmailPasswordLogin.finalEmail != null)) {
      if (await context
          .loginRepository()
          .sendLoginEmail(EmailPasswordLogin.finalEmail!)) {
        navigateFadeToReplace(
          context,
          (ctx) => LoginAwaitEmailScreen(
            child: widget.child,
            loginComplete: () async {
              navigateFadeToReplace(ctx, (ctx) => widget.child!);
            },
          ),
          popRemaining: true,
        );
      } else {
        setState(() {
          error = 'login.error.user_or_password_unknown';
          _loading = false;
        });
      }
    }
  }

  @override
  Widget buildLoginPage(BuildContext context) {
    if (context
            .login()
            .config
            .loginOptions
            .loginMethod
            .contains(LoginMethod.LoginInteractiveWithMagicLink) &&
        !context
            .login()
            .config
            .loginOptions
            .loginMethod
            .contains(LoginMethod.LoginInteractiveWithUsernameAndPassword)) {
      passwordLess = true;
    }

    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 60),
          alignment: Alignment.topCenter,
          child: Text(
            context.translate('login.text.title'),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 10),
          alignment: Alignment.topCenter,
          child: Text(
            context.translate('login.text.subtitle'),
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        if (FlutterLogin.of(context).config.loginOptions.loginImage != '') ...[
          const LoginImage(),
        ],
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 50,
              right: 50,
              top: FlutterLogin.of(context).config.loginOptions.loginImage == ''
                  ? MediaQuery.of(context).size.height * 0.3
                  : 0,
            ),
            child: Container(
              child: Column(
                children: <Widget>[
                  context.login().config.appTheme.inputs.textField(
                        value: EmailPasswordLogin.finalEmail ?? '',
                        onChange: (val, valid) {
                          if (valid) {
                            onEmailChanged(val);
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        title: context.translate(
                          'login.input.email',
                          defaultValue: 'Email address',
                        ),
                      ),
                  if (!passwordLess) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ObscureTextInputField(
                        value: EmailPasswordLogin.finalPassword,
                        title: context.translate(
                          'login.input.password',
                          defaultValue: 'Password',
                        ),
                        onChange: (val, valid) {
                          if (valid) {
                            onPasswordChanged(val);
                          }
                        },
                      ),
                    ),
                  ],
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: context
                        .login()
                        .config
                        .appTheme
                        .buttons
                        .tertiaryButton(
                          context: context,
                          child: Text(
                            context.translate('login.button.forgot_password'),
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          onPressed: widget.onPressedForgotPassword ??
                              () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPassword(),
                                    ),
                                  ),
                        ),
                  ),
                  if (context.login().config.loginOptions.autoLoginMode !=
                          AutoLoginMode.alwaysOff &&
                      context.login().config.loginOptions.autoLoginMode !=
                          AutoLoginMode.alwaysOn) ...[
                    Theme(
                      data: Theme.of(context).copyWith(
                        textTheme: Theme.of(context).textTheme.copyWith(
                              headline6: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.color,
                                  ),
                            ),
                      ),
                      child: context.login().config.appTheme.inputs.checkBox(
                            value: autoLogin ??
                                context
                                        .login()
                                        .config
                                        .loginOptions
                                        .autoLoginMode ==
                                    AutoLoginMode.defaultOn,
                            title: context.translate(
                              'login.input.stay_logged_in',
                              defaultValue: 'Stay logged in',
                            ),
                            onChange: (value, valid) => autoLogin = value,
                          ),
                    ),
                  ],
                  if (error.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Text(
                        error == ''
                            ? error
                            : context.translate(
                                error,
                                defaultValue:
                                    'An error occurred when logging in: $error',
                              ),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Theme.of(context).errorColor),
                      ),
                    ),
                  ],
                  FlutterLogin.of(context)
                      .config
                      .appTheme
                      .buttons
                      .primaryButton(
                        context: context,
                        isLoading: _loading,
                        isDisabled: _loading,
                        child: Text(
                          context.translate(
                            'login.button.login',
                            defaultValue: 'Log in',
                          ),
                          style: Theme.of(context).textTheme.button,
                          textAlign: TextAlign.center,
                        ),
                        onPressed: _handleLoginPress,
                      ),
                  if (context.login().config.loginOptions.loginMethod.contains(
                            LoginMethod.LoginInteractiveWithMagicLink,
                          ) &&
                      context.login().config.loginOptions.loginMethod.contains(
                            LoginMethod.LoginInteractiveWithUsernameAndPassword,
                          )) ...[
                    FlutterLogin.of(context)
                        .config
                        .appTheme
                        .buttons
                        .tertiaryButton(
                          context: context,
                          child: Text(
                            passwordLess
                                ? context.translate(
                                    'login.button.login_email_password',
                                    defaultValue: 'Log in with password',
                                  )
                                : context.translate(
                                    'login.button.login_email_only',
                                    defaultValue: 'Log in with link',
                                  ),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          onPressed: () =>
                              setState(() => passwordLess = !passwordLess),
                        )
                  ],
                  if (context
                          .login()
                          .config
                          .registrationOptions
                          .registrationMode ==
                      RegistrationMode.Enabled) ...[
                    context.login().config.appTheme.buttons.tertiaryButton(
                          context: context,
                          child: Text(
                            context.translate(
                              'login.button.no_account',
                              defaultValue: "I don't have an account yet",
                            ),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          onPressed: () {
                            FlutterLogin.of(context)
                                .config
                                .loginOptions
                                .onPressRegister!();
                          },
                        ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
