import 'dart:async';
import 'package:flutter/material.dart';
import 'flutter_login_view.dart';
import 'sdk/screen.dart';
import 'sdk/user.dart';

mixin FlutterLoginSdk {
  static final DialogService _dialogService = DialogService();
  static final UserService _userService = UserService();
  static final ScreenService _screenService = ScreenService();

  DialogService get dialogs => _dialogService;
  UserService get users => _userService;
  ScreenService get screens => _screenService;

  static DialogService get dialogService => _dialogService;
  static UserService get userService => _userService;
  static ScreenService get screenService => _screenService;

  void dispose() {
    _userService.dispose();
  }
}

class DialogService {
  Future<T?> showDialog<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool barrierDismissible = true,
    Color? barrierColor = Colors.black54,
    String? barrierLabel,
    bool useSafeArea = false,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
  }) =>
      showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor,
        barrierLabel: barrierLabel,
        useSafeArea: useSafeArea,
        useRootNavigator: useRootNavigator,
        builder: (ctx) => FlutterLogin.from(
          appShell: FlutterLogin.of(context),
          child: Builder(
            builder: builder,
          ),
        ),
      );
}
