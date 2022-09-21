import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login_view.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../extensions/widget.dart';
import '../form/inputs/validators/phone_number_validator.dart';
import 'login_phone_number_verify.dart';

class LoginPhoneNumber extends StatefulWidget {
  const LoginPhoneNumber({
    required this.navRegistration,
    required this.navAfterLogin,
    required this.title,
    super.key,
  });

  final Function navRegistration;
  final Function navAfterLogin;
  final String title;

  @override
  LoginPhoneNumberState createState() => LoginPhoneNumberState();
}

class LoginPhoneNumberState extends State<LoginPhoneNumber>
    with NavigateWidgetMixin {
  String? phoneNumber;
  String? errorMsg;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: ListView(
          children: [
            Stack(
              children: [
                if (Navigator.of(context).canPop()) ...[
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(top: 10, left: 5),
                    child: context.login().config.appTheme.buttons.backButton(
                          context: context,
                        ),
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Center(
                    child: Text(
                      widget.title,
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
                top: 30,
              ),
              child: Column(
                children: [
                  InternationalPhoneNumberInput(
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      trailingSpace: false,
                      useEmoji: true,
                      setSelectorButtonAsPrefixIcon: true,
                    ),
                    onInputChanged: (PhoneNumber value) {
                      setState(() {
                        if (PhoneNumberValidator(
                          errorMessage: '',
                        ).validate(
                          value.toString(),
                        )) {
                          phoneNumber = value.toString();
                        } else {
                          phoneNumber = null;
                        }
                      });
                    },
                  ),
                  if (errorMsg != null) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        context.translate(errorMsg!),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Theme.of(context).errorColor,
                            ),
                      ),
                    ),
                  ],
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: context
                        .login()
                        .config
                        .appTheme
                        .buttons
                        .primaryButton(
                          context: context,
                          isLoading: _loading,
                          isDisabled: _loading,
                          child: Text(
                            context.translate(
                              'login_phone_number.button.submit',
                            ),
                            style: Theme.of(context).textTheme.button,
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            if (phoneNumber != null) {
                              setState(() {
                                errorMsg = null;
                                _loading = true;
                              });
                              context
                                  .loginRepository()
                                  .trySignInWithPhoneNumber(
                                    phoneNumber: phoneNumber!,
                                    onCodeSent: (
                                      verificationId,
                                      resendToken,
                                      resultWeb,
                                    ) =>
                                        navigateFadeTo(
                                      context,
                                      (ctx) => LoginPhoneNumberVerify(
                                        resultWeb: resultWeb,
                                        verificationId: verificationId,
                                        phoneNumber: phoneNumber!,
                                        onLogin: _onLoggedIn,
                                      ),
                                    ),
                                    onAutoLogin: (_) => _onLoggedIn,
                                    onVerificationFailed: (String errorCode) {
                                      if (errorCode == 'invalid-phone-number') {
                                        setState(() {
                                          errorMsg = context.translate(
                                            'login_phone_number.text.error.invalid_phone_number',
                                          );
                                          _loading = false;
                                        });
                                      } else {
                                        setState(() {
                                          errorMsg = context.translate(
                                            'login_phone_number.text.error.verification_failed',
                                          );
                                          _loading = false;
                                        });
                                      }
                                    },
                                  );
                            }
                          },
                        ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _onLoggedIn(LoginUser? user) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool('autoLogin', true);
    if (user != null) {
      if (await context.loginRepository().isRegistrationRequired(user)) {
        widget.navRegistration.call();
      } else {
        widget.navAfterLogin.call();
      }
    }
  }
}
