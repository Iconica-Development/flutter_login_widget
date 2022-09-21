import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login_view.dart';
import '../form/inputs/validators/email_validator.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  String? email;
  bool showError = false;

  @override
  Widget build(BuildContext context) {
    void showAlert({
      required String title,
      required String text,
      required String buttonTitle,
      VoidCallback? buttonAction,
    }) =>
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (buttonAction != null) {
                    buttonAction();
                  }
                },
                child: Text(buttonTitle),
              ),
            ],
          ),
        );

    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.translate('forgot_password.text.title'),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(
                      top: 27,
                      left: 5,
                    ),
                    child: context.login().config.appTheme.buttons.backButton(
                          context: context,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      context.translate('forgot_password.text.body'),
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 20),
                        ),
                        context.login().config.appTheme.inputs.textField(
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
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
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
              child: context.login().config.appTheme.buttons.primaryButton(
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
                            .loginRepository()
                            .forgotPassword(email!);

                        if (result) {
                          showAlert(
                            title: context.translate(
                              'forgot_password.dialog.text.title',
                            ),
                            text: context.translate(
                              'forgot_password.dialog.text.body',
                              arguments: [email],
                            ),
                            buttonTitle: context.translate(
                              'forgot_password.dialog.text.button',
                            ),
                            buttonAction: () {
                              Navigator.pop(context);
                            },
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
    );
  }
}
