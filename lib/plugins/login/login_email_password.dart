import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  String password = '';
  late SharedPreferences prefs;
  bool passwordLess = false;
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  String _emailErrorMessage = '';
  String _passwordErrorMessage = '';

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
    if (!_formKey.currentState!.validate()) {
      return;
    }

    var loginRepository = context.loginRepository();

    setState(() {
      _loading = true;
    });

    if (!passwordLess &&
        (EmailPasswordLogin.finalEmail != null) &&
        (EmailPasswordLogin.finalPassword != null)) {
      await loginRepository
          .login(
            EmailPasswordLogin.finalEmail!,
            EmailPasswordLogin.finalPassword!,
          )
          .then(
            (response) => response
                ? navigateFadeToReplace(
                    context,
                    (context) => widget.child,
                    popRemaining: true,
                  )
                : setState(
                    () {
                      parseLoginMessage();
                      _loading = false;
                    },
                  ),
          );
    } else if (passwordLess && (EmailPasswordLogin.finalEmail != null)) {
      await loginRepository
          .sendLoginEmail(
            EmailPasswordLogin.finalEmail!,
          )
          .then(
            (response) => response
                ? navigateFadeToReplace(
                    context,
                    (ctx) => LoginAwaitEmailScreen(
                      child: widget.child,
                      loginComplete: () async {
                        navigateFadeToReplace(ctx, (ctx) => widget.child!);
                      },
                    ),
                    popRemaining: true,
                  )
                : setState(
                    () {
                      _emailErrorMessage =
                          'login.error.user_or_password_unknown';
                      _loading = false;
                    },
                  ),
          );
    }

    _formKey.currentState!.validate();
    _emailErrorMessage = '';
    _passwordErrorMessage = '';
  }

  void parseLoginMessage() {
    var loginRepository = context.loginRepository();
    var loginError = loginRepository.getLoginError();

    setState(() {
      switch (loginError) {
        case 'login.error.invalid_email':
          _emailErrorMessage = loginError;
          break;
        default:
          _passwordErrorMessage = loginError;
      }
    });
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
        if (FlutterLogin.of(context).config.loginOptions.showLoginTitle)
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: EmailPasswordLogin.finalEmail ?? '',
                      onChanged: onEmailChanged,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: context.translate(
                          'login.input.email',
                          defaultValue: 'Email address',
                        ),
                      ),
                      validator: (value) {
                        if (_emailErrorMessage != '') {
                          return context.translate(_emailErrorMessage);
                        }
                        if (value == null || value.isEmpty) {
                          return context.translate('login.text.enter_email');
                        }
                        return null;
                      },
                    ),
                    if (!passwordLess) ...[
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: TextFormField(
                          initialValue: EmailPasswordLogin.finalPassword ?? '',
                          obscureText: true,
                          onChanged: onPasswordChanged,
                          decoration: InputDecoration(
                            labelText: context.translate(
                              'login.input.password',
                              defaultValue: 'Password',
                            ),
                          ),
                          validator: (value) {
                            if (_passwordErrorMessage != '') {
                              return context.translate(_passwordErrorMessage);
                            }
                            if (value == null || value.isEmpty) {
                              return context
                                  .translate('login.text.enter_password');
                            }
                            return null;
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
                    if (context
                            .login()
                            .config
                            .loginOptions
                            .loginMethod
                            .contains(
                              LoginMethod.LoginInteractiveWithMagicLink,
                            ) &&
                        context
                            .login()
                            .config
                            .loginOptions
                            .loginMethod
                            .contains(
                              LoginMethod
                                  .LoginInteractiveWithUsernameAndPassword,
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
        ),
      ],
    );
  }
}
