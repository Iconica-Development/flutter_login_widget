import 'package:flutter/material.dart';
import '../extensions/widget.dart';
import '../flutter_login_view.dart';
import '../plugins/login/choose_login.dart';

class ScreenService with NavigateWidgetMixin {
  late bool shouldShowIntroductionScreen;
  late bool shouldShowPolicyPage;

  Widget getAppshellScreenWrapper(
    BuildContext context, {
    required Widget child,
    String? backgroundImg,
  }) {
    var bgImage =
        backgroundImg ?? context.login().config.appOptions.backgroundImage;
    if (bgImage.isNotEmpty) {
      late AssetImage image;
      var split = bgImage.split(';');

      image = split.length < 2
          ? AssetImage(bgImage)
          : AssetImage(
              split.first,
              package: split.last,
            );

      return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: image,
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      );
    } else {
      return child;
    }
  }

  void openLoginScreen(BuildContext context) => navigateFadeTo(
        context,
        (ctx) => (FlutterLogin.of(context)
                    .config
                    .loginOptions
                    .loginMethod
                    .contains(LoginMethod.LoginInteractiveWithSocial) ||
                FlutterLogin.of(context)
                    .config
                    .loginOptions
                    .loginMethod
                    .contains(LoginMethod.LoginInteractiveWithPhoneNumber))
            ? ChooseLogin(
                allowExit: true,
                child: context.login().app,
              )
            : EmailPasswordLogin(
                allowExit: true,
                child: context.login().app,
              ),
      );
}
