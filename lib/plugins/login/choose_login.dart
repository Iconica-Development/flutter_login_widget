import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login_view.dart';
import 'login_image.dart';
import 'login_registration_buttons.dart';
import 'login_widget.dart';

class ChooseLogin extends Login {
  const ChooseLogin({
    Widget? child,
    bool allowExit = false,
    super.key,
  }) : super(child: child, allowExit: allowExit);

  static String? finalEmail;
  static String? finalPassword;

  createState() => ChooseLoginState();
}

class ChooseLoginState extends LoginState<ChooseLogin> {
  void navigateToEmailPage(BuildContext context) {
    navigateFadeTo(
      context,
      (ctx) => EmailPasswordLogin(
        child: widget.child,
      ),
    );
  }

  @override
  Widget buildLoginPage(BuildContext context) => Column(
        children: [
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
          const LoginImage(),
          LoginRegistrationButtons(
            emailText: context.translate(
              'login.button.login_email',
              defaultValue: 'Login with e-mail',
            ),
            phoneText: context.translate('login.button.login_phone_number'),
            navAfterLogin: () => navigateFadeToReplace(
              context,
              (ctx) => widget.child,
              popRemaining: true,
            ),
            navRegistration: () {
              debugPrint('Register');
            },
            navEmail: () => navigateToEmailPage(context),
          ),
          if (FlutterLogin.of(context)
                  .config
                  .registrationOptions
                  .registrationMode ==
              RegistrationMode.Enabled) ...[
            Align(
              alignment: Alignment.bottomCenter,
              child: FlutterLogin.of(context)
                  .config
                  .appTheme
                  .buttons
                  .tertiaryButton(
                    context: context,
                    child: Text(
                      context.translate(
                        'login.button.no_account',
                        defaultValue: "I don't have an account yet",
                      ),
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    onPressed: () {
                      FlutterLogin.of(context)
                          .config
                          .loginOptions
                          .onPressRegister!();
                    },
                  ),
            ),
          ],
        ],
      );
}
