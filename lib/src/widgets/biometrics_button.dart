import "dart:async";
import "dart:io";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

class BiometricsButton extends StatelessWidget {
  const BiometricsButton({
    required this.onPressed,
    super.key,
  });

  static const Size buttonSize = Size(40, 40);

  final FutureOr<void> Function() onPressed;

  @override
  Widget build(BuildContext context) {
    // handle unsupported platforms
    if (kIsWeb || Platform.isLinux) return SizedBox(width: buttonSize.width);
    Widget biometricsWidget;

    if (Platform.isIOS || Platform.isMacOS) {
      biometricsWidget = Image(
        image: const AssetImage(
          "assets/ios_fingerprint.png",
          package: "flutter_login",
        ),
        width: buttonSize.width,
        height: buttonSize.height,
      );
    } else {
      biometricsWidget = Icon(
        Icons.fingerprint,
        size: buttonSize.width,
      );
    }

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onPressed,
      child: biometricsWidget,
    );
  }
}
