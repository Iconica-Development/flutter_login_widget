import 'package:flutter/material.dart';
import '../dialog/alert_dialog.dart';

class Resend extends StatefulWidget {
  const Resend({super.key});

  @override
  ConfirmationState createState() => ConfirmationState();
}

class ConfirmationState extends State<Resend> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => AppShellAlertDialog.singleButton(
        title: 'login_resend_email.dialog.text.title',
        body: 'login_resend_email.dialog.text.body',
        buttonText: 'login_resend_email.dialog.button.ok',
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
}
