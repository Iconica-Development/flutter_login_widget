import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login_view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../form/fields/obscure_text_input_field.dart';

class EmailPasswordForm extends StatefulWidget {
  const EmailPasswordForm({
    required this.onLogin,
    this.onForgetPassword,
    this.image,
    this.agreementLink,
    this.email,
    this.password,
    Key? key,
  }) : super(key: key);

  final Widget? image;
  final String? agreementLink;
  final String? password;
  final String? email;
  final FutureOr<String?> Function(String email, String password) onLogin;
  final FutureOr<void> Function(String email)? onForgetPassword;

  @override
  State<EmailPasswordForm> createState() => _EmailPasswordFormState();
}

class _EmailPasswordFormState extends State<EmailPasswordForm> {
  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var shellInputs = context.appShell().config.appTheme.inputs;
    var buttons = context.appShell().config.appTheme.buttons;
    var textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        if (widget.image != null) widget.image!,
        const SizedBox(
          height: 32,
        ),
        Text(
          context.translate('login.text.title'),
          style: textTheme.headline2,
        ),
        const SizedBox(
          height: 32,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: shellInputs.textField(
            onSubmitted: (_) {
              if (kIsWeb) {
                widget.onLogin.call(email, password);
              }
            },
            title: context.translate('login.input.email'),
            value: email,
            keyboardType: TextInputType.emailAddress,
            onChange: (val, valid) {
              if (valid) {
                email = val;
              }
            },
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ObscureTextInputField(
            onSubmitted: (_) {
              if (kIsWeb) {
                widget.onLogin.call(email, password);
              }
            },
            title: context.translate('login.input.password'),
            value: password,
            onChange: (val, valid) {
              if (valid) {
                password = val;
              }
            },
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        if (widget.onForgetPassword != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buttons.tertiaryButton(
                context: context,
                child: Text(
                  context.translate('login.button.forgot_password'),
                ),
                onPressed: () {
                  widget.onForgetPassword?.call(email);
                },
              ),
            ],
          ),
        const SizedBox(
          height: 40,
        ),
        buttons.primaryButton(
          context: context,
          child: Text(
            context.translate('login.button.login'),
          ),
          onPressed: () {
            widget.onLogin.call(email, password);
          },
        ),
        const SizedBox(
          height: 32,
        ),
        if (widget.agreementLink != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.translate('login.button.conditions.label'),
                style: textTheme.bodySmall?.copyWith(
                  fontSize: 12,
                ),
              ),
              buttons.tertiaryButton(
                context: context,
                child: Text(context.translate('login.button.conditions')),
                onPressed: () {
                  launchUrl(Uri.parse(widget.agreementLink!));
                },
              ),
            ],
          ),
        ]
      ],
    );
  }
}
