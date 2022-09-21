import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login_view.dart';
import '../../extensions/widget.dart';

abstract class Login extends StatefulWidget {
  const Login({
    required this.allowExit,
    this.child,
    super.key,
  });
  final Widget? child;
  final bool allowExit;

  @override
  LoginState createState();
}

abstract class LoginState<L extends Login> extends State<L>
    with NavigateWidgetMixin {
  void navigateToEmailPageReplace(
    BuildContext context, {
    String? email,
    String? password,
  }) {
    navigateFadeToReplace(
      context,
      (_) => EmailPasswordLogin(
        emailsave: email,
        passwordsave: password,
        child: widget.child,
      ),
      popRemaining: true,
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: context.login().screens.getAppshellScreenWrapper(
              context,
              backgroundImg:
                  context.login().config.loginOptions.backgroundImage,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: buildLoginPage(context),
                    ),
                    if (widget.allowExit) ...[
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30, right: 10),
                          child: SizedBox(
                            height: 48,
                            width: 48,
                            child: GestureDetector(
                              key: const Key('navigateToSettings'),
                              child: const Icon(
                                Icons.close,
                                size: 24,
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
      );

  Widget buildLoginPage(BuildContext context);
}
