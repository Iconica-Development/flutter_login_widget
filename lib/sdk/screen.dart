import 'package:flutter/material.dart';
import '../flutter_login_view.dart';

class ScreenService {
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
}
