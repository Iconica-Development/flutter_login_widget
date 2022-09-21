import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login_view.dart';
import 'default_theme.dart';

abstract class AppButtons {
  const AppButtons();

  Widget primaryButton({
    required BuildContext context,
    required Widget child,
    required VoidCallback onPressed,
    bool isDisabled = false,
    bool isLoading = false,
  });

  Widget primaryDisabledButton({
    required BuildContext context,
    required Widget child,
    required VoidCallback onPressed,
  });

  Widget secondaryButton({
    required BuildContext context,
    required Widget child,
    required VoidCallback onPressed,
    bool isDisabled = false,
    bool isLoading = false,
  });

  Widget tertiaryButton({
    required BuildContext context,
    required Widget child,
    required VoidCallback onPressed,
    bool isDisabled = false,
    bool isLoading = false,
  });

  Widget iconButton({
    required BuildContext context,
    required VoidCallback onPressed,
    required Widget icon,
    Color? color,
    double? iconSize,
  });

  Widget backButton({
    required BuildContext context,
    VoidCallback? onPressed,
  });
}

class AppShellDefaultButtons implements AppButtons {
  const AppShellDefaultButtons();

  @override
  Widget primaryButton({
    required BuildContext context,
    required Widget child,
    required VoidCallback onPressed,
    bool isDisabled = false,
    bool isLoading = false,
  }) =>
      InkWell(
        onTap: () {
          if (!isDisabled) {
            onPressed.call();
          }
        },
        borderRadius: BorderRadius.circular(1000),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          decoration: BoxDecoration(
            color: !isDisabled
                ? Theme.of(context).buttonTheme.colorScheme?.primary
                : Theme.of(context).disabledColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: isLoading
              ? Text('. . .', style: Theme.of(context).textTheme.button)
              : child,
        ),
      );

  @override
  Widget primaryDisabledButton({
    required BuildContext context,
    required Widget child,
    required VoidCallback onPressed,
  }) =>
      MaterialButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Theme.of(context).disabledColor,
        onPressed: onPressed,
        child: child,
      );

  @override
  Widget secondaryButton({
    required BuildContext context,
    required Widget child,
    required VoidCallback onPressed,
    bool isDisabled = false,
    bool isLoading = false,
  }) =>
      OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Theme.of(context).backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(
            color: Theme.of(context).buttonTheme.colorScheme?.primary ??
                defaultTheme.colorScheme.primary,
          ),
        ),
        onPressed: onPressed,
        child: child,
      );

  @override
  Widget tertiaryButton({
    required BuildContext context,
    required Widget child,
    required VoidCallback onPressed,
    bool isDisabled = false,
    bool isLoading = false,
  }) =>
      TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Theme.of(context).backgroundColor,
        ),
        onPressed: onPressed,
        child: child,
      );

  @override
  Widget iconButton({
    required BuildContext context,
    required VoidCallback onPressed,
    required Widget icon,
    Color? color,
    double? iconSize,
  }) =>
      IconButton(
        onPressed: onPressed,
        icon: icon,
        color: color,
        iconSize: iconSize ?? 24.0,
      );

  @override
  Widget backButton({
    required BuildContext context,
    VoidCallback? onPressed,
  }) =>
      IconButton(
        onPressed: onPressed ?? () => Navigator.pop(context),
        icon: Icon(
          context.login().config.appTheme.icons.backButton,
          size: 24,
        ),
      );
}
