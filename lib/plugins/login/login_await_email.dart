import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login_view.dart';
import '../../extensions/widget.dart';
import 'resend.dart';

class LoginAwaitEmailScreen extends StatefulWidget {
  const LoginAwaitEmailScreen({
    required this.child,
    super.key,
    this.loginComplete,
  });
  final Function? loginComplete;
  final Widget? child;

  @override
  LoginAwaitEmailScreenState createState() => LoginAwaitEmailScreenState();
}

class LoginAwaitEmailScreenState extends State<LoginAwaitEmailScreen>
    with NavigateWidgetMixin {
  @override
  void initState() {
    super.initState();
  }

  void navigateToEmailPage(BuildContext context) {
    navigateFadeTo(
      context,
      (ctx) => EmailPasswordLogin(child: widget.child),
    );
  }

  void navigateToEmailPageReplace(
    BuildContext context, {
    String? email,
    String? password,
  }) {
    navigateFadeToReplace(
      context,
      (context) => EmailPasswordLogin(
        emailsave: email,
        passwordsave: password,
        child: widget.child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Material(
        color: Theme.of(context).backgroundColor,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(height: 10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: BackButton(),
                ),
                TextButton(
                  style: TextButton.styleFrom(shape: const CircleBorder()),
                  onPressed: null,
                  child: Icon(
                    context.login().config.appTheme.icons.magicLinkAwaitEmail,
                  ),
                ),
                Container(height: 20),
                Text(
                  context.translate(
                    'login_await_email.text.title',
                    defaultValue: 'Email sent',
                  ),
                  style: Theme.of(context).textTheme.headline6,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                    right: 40,
                    top: 20,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: context.translate(
                            'login_await_email.text.sent_to_part_1',
                            defaultValue: 'Email was sent to ',
                          ),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        TextSpan(
                          text: '${EmailPasswordLogin.finalEmail}. ',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        TextSpan(
                          text: context.translate(
                            'login_await_email.text.sent_to_part_2',
                            defaultValue:
                                'If your emailaddress was registered, a link will be available to login \r\n\r\nMake sure to check your spamfolder!\r\n',
                          ),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  height: 15,
                ),
                FlutterLogin.of(context).config.appTheme.buttons.tertiaryButton(
                      context: context,
                      child: Text(
                        context.translate(
                          'login_await_email.button.resend',
                          defaultValue: 'Send again',
                        ),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      onPressed: () async {
                        navigateFadeTo(
                          context,
                          (context) => const Resend(),
                          opaque: false,
                          barrierColor: Colors.black54,
                        );
                        await context
                            .loginRepository()
                            .sendLoginEmail(EmailPasswordLogin.finalEmail!);
                      },
                    ),
                Container(
                  height: 20,
                ),
                FlutterLogin.of(context).config.appTheme.buttons.tertiaryButton(
                      context: context,
                      child: Text(
                        context.translate(
                          'login.button.no_account',
                          defaultValue: "I don't have an account",
                        ),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      onPressed: () {
                        FlutterLogin.of(context)
                            .config
                            .loginOptions
                            .onPressRegister!();
                      },
                    )
              ],
            ),
          ],
        ),
      );
}
