import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

class EmailPasswordLoginForm extends StatefulWidget {
  const EmailPasswordLoginForm({
    super.key,
    this.onForgotPassword,
    required this.onLogin,
    this.onRegister,
    this.options = const LoginOptions(),
  });

  final LoginOptions options;
  final void Function(String email)? onForgotPassword;
  final FutureOr<void> Function(String email, String password)? onRegister;
  final FutureOr<void> Function(String email, String password) onLogin;

  @override
  State<EmailPasswordLoginForm> createState() => _EmailPasswordLoginFormState();
}

class _EmailPasswordLoginFormState extends State<EmailPasswordLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _formValid = ValueNotifier(false);
  bool _obscurePassword = true;

  String? emailValidationText;
  String? passwordValidationText;

  String _currentEmail = '';
  String _currentPassword = '';

  void _updateCurrentEmail(String email) {
    _currentEmail = email;
    _validate();
  }

  void _updateCurrentPassword(String password) {
    _currentPassword = password;
    _validate();
  }

  void _validate() {
    late bool isValid =
        widget.options.validations.validateEmail(_currentEmail) == null &&
            widget.options.validations.validatePassword(_currentPassword) ==
                null;
    if (isValid != _formValid.value) {
      _formValid.value = isValid;
    }
  }

  Future<void> _handleLogin() async {
    if (mounted) {
      var form = _formKey.currentState!;
      if (form.validate()) {
        await widget.onLogin(
          _currentEmail,
          _currentPassword,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _currentEmail = widget.options.initialEmail;
    _currentPassword = widget.options.initialPassword;
    _validate();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var options = widget.options;
    return CustomScrollView(
      physics: MediaQuery.of(context).viewInsets.bottom == 0
          ? const NeverScrollableScrollPhysics()
          : null,
      slivers: [
        SliverFillRemaining(
          fillOverscroll: true,
          hasScrollBody: false,
          child: Column(
            children: [
              if (options.spacers.spacerBeforeTitle != null) ...[
                Spacer(flex: options.spacers.spacerBeforeTitle!),
              ],
              if (options.title != null) ...[
                const SizedBox(
                  height: 60,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: _wrapWithDefaultStyle(
                    options.title,
                    theme.textTheme.headlineSmall,
                  ),
                )
              ],
              if (options.spacers.spacerAfterTitle != null) ...[
                Spacer(flex: options.spacers.spacerAfterTitle!),
              ],
              if (options.subtitle != null) ...[
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: _wrapWithDefaultStyle(
                    options.subtitle,
                    theme.textTheme.titleSmall,
                  ),
                )
              ],
              if (options.spacers.spacerAfterSubtitle != null) ...[
                Spacer(flex: options.spacers.spacerAfterSubtitle!),
              ],
              if (options.image != null) ...[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: options.image,
                ),
              ],
              if (options.spacers.spacerAfterImage != null) ...[
                Spacer(flex: options.spacers.spacerAfterImage!),
              ],
              Expanded(
                flex: options.spacers.formFlexValue,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: options.maxFormWidth ?? 300,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Align(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          options.emailInputContainerBuilder(
                            Column(
                              children: [
                                SizedBox(
                                  height: options.textFieldHeight,
                                  width: options.textFieldWidth,
                                  child: TextFormField(
                                    onChanged: _updateCurrentEmail,
                                    validator: (value) {
                                      var validationResult = widget
                                          .options.validations
                                          .validateEmail(value);
                                      setState(() {
                                        emailValidationText = validationResult;
                                      });
                                      return;
                                    },
                                    initialValue: options.initialEmail,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    style: options.emailTextStyle,
                                    decoration: options.emailDecoration,
                                  ),
                                ),
                                if (emailValidationText != null)
                                  options.errorMessageBuilder(
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        emailValidationText!,
                                        style: options.errorStyle,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          options.passwordInputContainerBuilder(
                            Column(
                              children: [
                                SizedBox(
                                  height: options.textFieldHeight,
                                  width: options.textFieldWidth,
                                  child: TextFormField(
                                    obscureText: _obscurePassword,
                                    onChanged: _updateCurrentPassword,
                                    validator: (value) {
                                      var validationResult = widget
                                          .options.validations
                                          .validatePassword(value);
                                      setState(() {
                                        passwordValidationText =
                                            validationResult;
                                      });
                                      return;
                                    },
                                    initialValue: options.initialPassword,
                                    keyboardType: TextInputType.visiblePassword,
                                    textInputAction: TextInputAction.done,
                                    style: options.passwordTextStyle,
                                    onFieldSubmitted: (_) => _handleLogin(),
                                    decoration:
                                        options.passwordDecoration.copyWith(
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _obscurePassword =
                                                !_obscurePassword;
                                          });
                                        },
                                        icon: Icon(
                                          _obscurePassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (passwordValidationText != null)
                                  options.errorMessageBuilder(
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(passwordValidationText!,
                                          style: options.errorStyle),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          if (widget.onForgotPassword != null) ...[
                            Align(
                              alignment: Alignment.topRight,
                              child: options.forgotPasswordButtonBuilder(
                                context,
                                () {
                                  widget.onForgotPassword?.call(_currentEmail);
                                },
                                false,
                                () {},
                                options,
                              ),
                            ),
                          ],
                          if (options.spacers.spacerAfterForm != null) ...[
                            Spacer(flex: options.spacers.spacerAfterForm!),
                          ],
                          const SizedBox(height: 8),
                          AnimatedBuilder(
                            animation: _formValid,
                            builder: (context, _) {
                              return options.loginButtonBuilder(
                                context,
                                _handleLogin,
                                !_formValid.value,
                                () {
                                  _formKey.currentState?.validate();
                                },
                                options,
                              );
                            },
                          ),
                          if (widget.onRegister != null) ...[
                            options.registrationButtonBuilder(
                              context,
                              () {
                                widget.onRegister?.call(
                                  _currentEmail,
                                  _currentPassword,
                                );
                              },
                              false,
                              () {},
                              options,
                            ),
                          ],
                          if (options.spacers.spacerAfterButton != null) ...[
                            Spacer(flex: options.spacers.spacerAfterButton!),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget? _wrapWithDefaultStyle(Widget? widget, TextStyle? style) {
    if (style == null || widget == null) {
      return widget;
    } else {
      return DefaultTextStyle(style: style, child: widget);
    }
  }
}
