import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login_view.dart';

class LoginImage extends StatelessWidget {
  const LoginImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var config = FlutterLogin.of(context).config.loginOptions;
    late AssetImage image;
    var split = config.loginImage.split(';');
    if (config.loginImage == '') {
      image = const AssetImage(
        'assets/images/login.png',
      );
    } else if (split.length < 2) {
      image = AssetImage(config.loginImage);
    } else {
      image = AssetImage(split.first, package: split.last);
    }
    return SizedBox(
      height: 200,
      width: 200,
      child: Image(
        image: image,
      ),
    );
  }
}
