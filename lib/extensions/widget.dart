import 'package:flutter/material.dart';

class NavigateWidgetMixin {
  void navigateFadeTo(
    BuildContext context,
    Function buildChild, {
    String? routeName,
    bool? opaque,
    Color? barrierColor,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: opaque ?? true,
        barrierColor: barrierColor,
        settings: RouteSettings(name: routeName),
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (
          context,
          animation,
          secondamination,
          child,
        ) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
        pageBuilder: (BuildContext ctx, animation, __) => buildChild(ctx),
      ),
    );
  }

  void navigateFadeToReplace(
    BuildContext context,
    Function buildChild, {
    bool popRemaining = false,
  }) {
    if (popRemaining) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (
          context,
          animation,
          secondamination,
          child,
        ) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
        pageBuilder: (BuildContext ctx, animation, __) => buildChild(ctx),
      ),
    );
  }
}
