import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login_view.dart';
import 'package:pinput/pinput.dart';
import '../../extensions/widget.dart';
import '../../model/confirmation_result.dart';
import '../../model/user.dart';

class LoginPhoneNumberVerify extends StatefulWidget {
  const LoginPhoneNumberVerify({
    required this.verificationId,
    required this.phoneNumber,
    required this.onLogin,
    this.resultWeb,
    super.key,
  });

  final String verificationId;
  final String phoneNumber;
  final Function(User? user) onLogin;
  final ConfirmationResult? resultWeb;

  @override
  LoginPhoneNumberVerifyState createState() => LoginPhoneNumberVerifyState(
        verificationId: this.verificationId,
        resultWeb: this.resultWeb,
      );
}

class LoginPhoneNumberVerifyState extends State<LoginPhoneNumberVerify>
    with NavigateWidgetMixin {
  LoginPhoneNumberVerifyState({required this.verificationId, this.resultWeb});
  String? code;
  bool errorMsg = false;
  String verificationId;
  ConfirmationResult? resultWeb;
  TextEditingController pinPutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: ListView(
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 5,
                  ),
                  child: context.appShell().config.appTheme.buttons.backButton(
                        context: context,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Center(
                    child: Text(
                      context.translate('login_phone_number_verify.text.title'),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
                top: 60,
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    width: 350,
                    child: Pinput(
                      controller: pinPutController,
                      length: 6,
                      onChanged: (String value) => setState(() {
                        errorMsg = false;
                      }),
                      onCompleted: (String code) async {
                        var user =
                            await context.appShellBackend().signInWithSMSCode(
                                  widget.verificationId,
                                  code,
                                  widget.phoneNumber,
                                  resultWeb: widget.resultWeb,
                                );
                        if (user != null) {
                          widget.onLogin.call(user);
                        } else {
                          setState(() {
                            errorMsg = true;
                          });
                        }
                      },
                      submittedPinTheme: _pinPutDecoration,
                      focusedPinTheme: _pinPutDecoration,
                      followingPinTheme: _pinPutDecoration,
                      autofocus: true,
                      pinAnimationType: PinAnimationType.none,
                    ),
                  ),
                  if (errorMsg) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        context.translate(
                          'login_phone_number_verify.text.error.wrong_code',
                        ),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Theme.of(context).errorColor),
                      ),
                    ),
                  ],
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          context.translate(
                            'login_phone_number_verify.text.nothing_received_yet',
                          ),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      context.appShell().config.appTheme.buttons.tertiaryButton(
                            context: context,
                            child: Text(
                              context.translate(
                                'login_phone_number_verify.button.send_again',
                              ),
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            onPressed: () {
                              context
                                  .appShellBackend()
                                  .trySignInWithPhoneNumber(
                                    phoneNumber: widget.phoneNumber,
                                    onCodeSent: (
                                      verificationId,
                                      resendToken,
                                      resultWeb,
                                    ) {
                                      this.verificationId = verificationId;
                                      this.resultWeb = resultWeb;
                                      pinPutController.clear();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            context.translate(
                                              'login_phone_verify.text.send_again',
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    onAutoLogin: (user) =>
                                        widget.onLogin.call(user),
                                  );
                            },
                          ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  PinTheme get _pinPutDecoration => PinTheme(
        constraints: const BoxConstraints(
          minHeight: 50.0,
          minWidth: 50.0,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            style: BorderStyle.solid,
            width: 2,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      );
}
