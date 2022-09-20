import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login_view.dart';
import '../../extensions/widget.dart';
import '../dialog/alert_dialog.dart';
import '../form/inputs/validators/email_validator.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({
    required this.onComplete,
    required this.onBack,
    super.key,
  });

  final VoidCallback onComplete;
  final VoidCallback onBack;

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm>
    with NavigateWidgetMixin {
  String? email;
  bool showError = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: context.appShell().screens.getAppshellScreenWrapper(
              context,
              backgroundImg:
                  context.appShell().config.loginOptions.backgroundImage,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(top: 27, left: 5),
                          child: context
                              .appShell()
                              .config
                              .appTheme
                              .buttons
                              .backButton(
                                context: context,
                                onPressed: widget.onBack,
                              ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              Text(
                                context.translate('forgot_password.text.title'),
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Text(
                                  context
                                      .translate('forgot_password.text.body'),
                                  style: Theme.of(context).textTheme.subtitle1,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 20),
                              ),
                              context
                                  .appShell()
                                  .config
                                  .appTheme
                                  .inputs
                                  .textField(
                                    title: context.translate(
                                      'forgot_password.input.email',
                                    ),
                                    validators: [
                                      EmailValidator(
                                        errorMessage: context.translate(
                                          'forgot_password.error.invalid_email',
                                        ),
                                      )
                                    ],
                                    onChange: (value, valid) {
                                      setState(() {
                                        showError = false;
                                      });
                                      if (valid) {
                                        email = value;
                                      }
                                    },
                                  ),
                              if (showError) ...[
                                Text(
                                  context.translate(
                                    'forgot_password.error.email_does_not_exist',
                                  ),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        color: Theme.of(context).errorColor,
                                      ),
                                ),
                              ],
                              const Padding(
                                padding: EdgeInsets.only(bottom: 30),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: context
                        .appShell()
                        .config
                        .appTheme
                        .buttons
                        .primaryButton(
                          context: context,
                          child: Text(
                            context.translate('forgot_password.button.submit'),
                            style: Theme.of(context).textTheme.button,
                          ),
                          onPressed: () async {
                            if (email != null) {
                              setState(() {
                                showError = false;
                              });

                              var result = await context
                                  .appShellBackend()
                                  .forgotPassword(email!);

                              if (result) {
                                await context.appShell().dialogs.showDialog(
                                      context: context,
                                      builder: (ctx) =>
                                          AppShellAlertDialog.singleButtonIcon(
                                        title:
                                            'forgot_password.dialog.text.title',
                                        body: context.translate(
                                          'forgot_password.dialog.text.body',
                                          arguments: [email!],
                                        ),
                                        icon: Icon(
                                          context
                                              .appShell()
                                              .config
                                              .appTheme
                                              .icons
                                              .forgotPasswordMail,
                                          size: 70,
                                        ),
                                        buttonText:
                                            'forgot_password.dialog.text.button',
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                          widget.onComplete.call();
                                        },
                                      ),
                                    );
                              } else {
                                setState(() {
                                  showError = true;
                                });
                              }
                            }
                          },
                        ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
