import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login_view.dart';
import '../../extensions/widget.dart';
import 'login_phone_number.dart';
import 'login_social_buttons.dart';

class LoginRegistrationButtons extends StatelessWidget
    with NavigateWidgetMixin {
  LoginRegistrationButtons({
    required this.emailText,
    required this.phoneText,
    required this.navAfterLogin,
    required this.navRegistration,
    required this.navEmail,
    super.key,
  });

  final String emailText;
  final String phoneText;
  final Function navAfterLogin;
  final Function navRegistration;
  final Function navEmail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _loginButtonsWithSeparator(
        context,
        _loginButtons(context),
      ),
    );
  }

  Widget _dividerOr(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 40,
        bottom: 30,
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 60,
                right: 20,
              ),
              child: Divider(
                thickness: 1,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          Text(context.translate('login.text.divider', defaultValue: 'Or')),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 60,
              ),
              child: Divider(
                thickness: 1,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _loginButtonsWithSeparator(
    BuildContext context,
    List<Widget> loginButtons,
  ) {
    var widgets = <Widget>[];
    if (loginButtons.length > 1) {
      for (var widget in loginButtons) {
        widgets.add(widget);
        if (loginButtons.last != widget) {
          widgets.add(_dividerOr(context));
        }
      }
      return widgets;
    } else {
      return loginButtons;
    }
  }

  List<Widget> _loginButtons(BuildContext context) {
    var loginButtons = <Widget>[];
    if (context
        .login()
        .config
        .loginOptions
        .loginMethod
        .contains(LoginMethod.LoginInteractiveWithSocial)) {
      loginButtons.add(
        LoginSocialButtons(
          navigateRegistration: navRegistration,
          navigateLogin: navAfterLogin,
        ),
      );
    }
    if (context
        .login()
        .config
        .loginOptions
        .loginMethod
        .contains(LoginMethod.LoginInteractiveWithPhoneNumber)) {
      loginButtons.add(
        FlutterLogin.of(context).config.appTheme.buttons.tertiaryButton(
              context: context,
              child:
                  Text(phoneText, style: Theme.of(context).textTheme.bodyText2),
              onPressed: () {
                navigateFadeTo(
                  context,
                  (ctx) => LoginPhoneNumber(
                    title: phoneText,
                    navRegistration: navRegistration,
                    navAfterLogin: navAfterLogin,
                  ),
                );
              },
            ),
      );
    }
    if (context
        .login()
        .config
        .loginOptions
        .loginMethod
        .contains(LoginMethod.LoginInteractiveWithUsernameAndPassword)) {
      loginButtons.add(
        FlutterLogin.of(context).config.appTheme.buttons.tertiaryButton(
              context: context,
              child:
                  Text(emailText, style: Theme.of(context).textTheme.bodyText2),
              onPressed: () {
                navEmail.call();
              },
            ),
      );
    }
    return loginButtons;
  }
}
