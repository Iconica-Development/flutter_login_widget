import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login_view.dart';

class AlertDialogAction {
  AlertDialogAction({
    required this.text,
    required this.onPressed,
    this.primary = false,
    this.secondary = false,
  }) : assert(
          !(primary && secondary),
          "AlertDialogAction can't be primary and secondary at the same time",
        );
  final String text;
  final bool primary;
  final bool secondary;
  final VoidCallback onPressed;
}

class AppShellAlertDialog extends StatelessWidget {
  factory AppShellAlertDialog.custom({
    required Widget body,
    required List<AlertDialogAction> buttons,
    bool? closeButton,
  }) =>
      AppShellAlertDialog._(
        closeButton: closeButton,
        buttons: buttons,
        body: (_) => body,
      );

  factory AppShellAlertDialog.singleButtonIcon({
    required String title,
    required String body,
    required Widget icon,
    required String buttonText,
    required VoidCallback onPressed,
    bool primary = false,
    bool secondary = false,
    bool? closeButton,
  }) =>
      AppShellAlertDialog.icon(
        closeButton: closeButton,
        title: title,
        icon: icon,
        body: body,
        buttons: [
          AlertDialogAction(
            text: buttonText,
            primary: primary,
            secondary: secondary,
            onPressed: onPressed,
          ),
        ],
      );

  factory AppShellAlertDialog.yesOrNoIcon({
    required String title,
    required String body,
    required Widget icon,
    required VoidCallback onYes,
    required VoidCallback onNo,
    bool focusYes = true,
    bool otherSecondary = false,
    bool? closeButton,
  }) =>
      AppShellAlertDialog.icon(
        closeButton: closeButton,
        title: title,
        body: body,
        icon: icon,
        buttons: _getYesNoDialogButtons(
          focusYes,
          otherSecondary,
          onYes,
          onNo,
        ),
      );

  factory AppShellAlertDialog.yesOrNo({
    required String title,
    required String body,
    required VoidCallback onYes,
    required VoidCallback onNo,
    bool focusYes = true,
    bool otherSecondary = false,
    bool? closeButton,
  }) =>
      AppShellAlertDialog.multiButton(
        closeButton: closeButton,
        title: title,
        body: body,
        buttons: _getYesNoDialogButtons(
          focusYes,
          otherSecondary,
          onYes,
          onNo,
        ),
      );

  factory AppShellAlertDialog.icon({
    required String title,
    required Widget icon,
    required String body,
    required List<AlertDialogAction> buttons,
    bool? closeButton,
  }) =>
      AppShellAlertDialog._(
        closeButton: closeButton,
        buttons: buttons,
        body: (context) => Container(
          child: Column(
            children: [
              icon,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  context.translate(title),
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: Text(
                  body,
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );

  factory AppShellAlertDialog.multiButton({
    required String title,
    required String body,
    required List<AlertDialogAction> buttons,
    bool? closeButton,
  }) =>
      AppShellAlertDialog._(
        closeButton: closeButton,
        buttons: buttons,
        body: (context) => Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text(
                  context.translate(title),
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyText2?.color,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: Text(
                  context.translate(body),
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );

  factory AppShellAlertDialog.singleButton({
    required String title,
    required String body,
    required String buttonText,
    required VoidCallback onPressed,
    bool primary = false,
    bool? closeButton,
  }) =>
      AppShellAlertDialog.multiButton(
        closeButton: closeButton,
        title: title,
        body: body,
        buttons: [
          AlertDialogAction(
            text: buttonText,
            onPressed: onPressed,
            primary: primary,
          ),
        ],
      );

  const AppShellAlertDialog._({
    required this.buttons,
    required this.body,
    this.closeButton = false,
  });
  final List<AlertDialogAction> buttons;
  final WidgetBuilder body;
  final bool? closeButton;

  static List<AlertDialogAction> _getYesNoDialogButtons(
    bool focusYes,
    bool otherSecondary,
    VoidCallback onYes,
    VoidCallback onNo,
  ) =>
      <AlertDialogAction>[
        if (focusYes) ...[
          AlertDialogAction(
            text: 'alertdialog.button.no',
            primary: !focusYes,
            secondary: !focusYes && otherSecondary,
            onPressed: onNo,
          ),
        ],
        AlertDialogAction(
          text: 'alertdialog.button.yes',
          primary: focusYes,
          secondary: !focusYes && otherSecondary,
          onPressed: onYes,
        ),
        if (!focusYes) ...[
          AlertDialogAction(
            text: 'alertdialog.button.no',
            primary: !focusYes,
            secondary: focusYes && otherSecondary,
            onPressed: onNo,
          ),
        ],
      ];

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const Spacer(),
          AlertDialog(
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            backgroundColor: Theme.of(context).cardColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          body.call(context),
                          Padding(
                            padding: EdgeInsets.only(
                              top: buttons.isNotEmpty ? 40 : 0,
                              bottom: 20,
                              left: 20,
                              right: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: buttons.map(
                                (e) {
                                  var buttons = context
                                      .appShell()
                                      .config
                                      .appTheme
                                      .buttons;
                                  var child = Text(
                                    context.translate(e.text),
                                  );
                                  if (e.primary) {
                                    return buttons.primaryButton(
                                      context: context,
                                      child: child,
                                      onPressed: e.onPressed,
                                    );
                                  } else if (e.secondary) {
                                    return buttons.secondaryButton(
                                      context: context,
                                      child: child,
                                      onPressed: e.onPressed,
                                    );
                                  } else {
                                    return buttons.tertiaryButton(
                                      context: context,
                                      child: child,
                                      onPressed: e.onPressed,
                                    );
                                  }
                                },
                              ).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (closeButton ?? false) ...[
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: context
                            .appShell()
                            .config
                            .appTheme
                            .buttons
                            .iconButton(
                              context: context,
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color,
                              icon: Icon(
                                context
                                    .appShell()
                                    .config
                                    .appTheme
                                    .icons
                                    .alertDialogClose,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          )
        ],
      );
}
