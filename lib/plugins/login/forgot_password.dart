import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login_view.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  String _email = '';
  final _formKey = GlobalKey<FormState>();
  String _emailErrorMessage = '';

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

    void onPressBtn() {
      if (!_formKey.currentState!.validate()) {
        return;
      }

      context.loginRepository().forgotPassword(_email).then(
        (response) {
          if (response) {
            showAlert(
              title: context.translate(
                'forgot_password.dialog.text.title',
              ),
              text: context.translate(
                'forgot_password.dialog.text.body',
                arguments: [_email],
              ),
              buttonTitle: context.translate(
                'forgot_password.dialog.text.button',
              ),
              buttonAction: () {
                Navigator.pop(context);
              },
            );
          } else {
            _emailErrorMessage = context.translate(
              'forgot_password.error.email_does_not_exist',
            );
            _formKey.currentState?.validate();
            _emailErrorMessage = '';
          }
        },
      );
    }

    return Material(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: context.login().config.loginOptions.customAppbarBuilder?.call(
                  context.translate('forgot_password.text.title'),
                  context,
                ) ??
            AppBar(
              title: Text(context.translate('forgot_password.text.title')),
            ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      context.translate('forgot_password.text.body'),
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                      ),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 20),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: context.translate(
                                'forgot_password.input.email',
                                defaultValue: 'Email address',
                              ),
                            ),
                            onChanged: (String value) => setState(
                              () {
                                _email = value;
                              },
                            ),
                            validator: (value) {
                              if (_emailErrorMessage.isNotEmpty) {
                                return _emailErrorMessage;
                              }

                              if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                              ).hasMatch(value!)) {
                                return context.translate(
                                  'forgot_password.error.invalid_email',
                                );
                              }
                              return null;
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 30),
                          ),
                        ],
                      ),
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
                    onPressed: onPressBtn,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
