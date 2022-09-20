import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../flutter_login_view.dart';

class LoginSocialButtons extends StatelessWidget {
  const LoginSocialButtons({
    required this.navigateRegistration,
    required this.navigateLogin,
    super.key,
  });

  final Function navigateRegistration;
  final Function navigateLogin;

  @override
  Widget build(BuildContext context) {
    var config = FlutterLogin.of(context).config;
    var backend = context.appShellBackend();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(
        config.loginOptions.socialOptions.socialLogins.length,
        (index) {
          var method = config.loginOptions.socialOptions.socialLogins[index];
          var padding = 0.0;
          var sidePadding = MediaQuery.of(context).size.width / 4;
          if (index <
              config.loginOptions.socialOptions.socialLogins.length - 1) {
            padding = 15;
          }
          return Container(
            padding: EdgeInsets.only(
              bottom: padding,
              left: sidePadding,
              right: sidePadding,
            ),
            child: config.appTheme.buttons.secondaryButton(
              context: context,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      _iconDataForSocial(method, context),
                      size: 24,
                      color: Theme.of(context).buttonTheme.colorScheme?.primary,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          context.translate(
                            method.toString(),
                            defaultValue: method
                                .toString()
                                .replaceAll('SocialLoginMethod.', ''),
                          ),
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.button!.copyWith(
                                fontSize: 16,
                                color: Theme.of(context)
                                    .buttonTheme
                                    .colorScheme
                                    ?.primary,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onPressed: () async {
                var user = await backend.signInWithSocial(
                  SocialLoginBundle(
                    method: method,
                    interactionType: SocialInteractionType.Login,
                  ),
                );
                var prefs = await SharedPreferences.getInstance();
                await prefs.setBool('autoLogin', true);
                if (user != null) {
                  if (await backend.isRegistrationRequired(user)) {
                    navigateRegistration();
                  } else {
                    navigateLogin();
                  }
                }
              },
            ),
          );
        },
      ),
    );
  }

  IconData? _iconDataForSocial(SocialLoginMethod method, BuildContext context) {
    switch (method) {
      case SocialLoginMethod.Google:
        return context.appShell().config.appTheme.icons.google;
      case SocialLoginMethod.FaceBook:
        return context.appShell().config.appTheme.icons.facebook;
      case SocialLoginMethod.Apple:
        return context.appShell().config.appTheme.icons.apple;
      case SocialLoginMethod.LinkedIn:
        return context.appShell().config.appTheme.icons.linkedIn;
      case SocialLoginMethod.Microsoft:
        return context.appShell().config.appTheme.icons.microsoft;
      case SocialLoginMethod.Twitter:
        return context.appShell().config.appTheme.icons.twitter;
      case SocialLoginMethod.Custom:
        return context.appShell().config.appTheme.icons.customSocial;
    }
  }
}
