import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

class EmailPasswordLoginForm extends StatefulWidget {
  const EmailPasswordLoginForm({
    required this.onLogin,
    super.key,
    this.onForgotPassword,
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
    late var isValid =
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
                ),
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
                ),
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
                            TextFormField(
                              onChanged: _updateCurrentEmail,
                              validator:
                                  widget.options.validations.validateEmail,
                              initialValue: options.initialEmail,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              style: options.emailTextStyle,
                              decoration: options.emailDecoration,
                            ),
                          ),
                          options.passwordInputContainerBuilder(
                            TextFormField(
                              obscureText: _obscurePassword,
                              onChanged: _updateCurrentPassword,
                              validator:
                                  widget.options.validations.validatePassword,
                              initialValue: options.initialPassword,
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              style: options.passwordTextStyle,
                              onFieldSubmitted: (_) async => _handleLogin(),
                              decoration: options.passwordDecoration.copyWith(
                                suffixIcon: options.showObscurePassword
                                    ? IconButton(
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
                                      )
                                    : null,
                              ),
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
                            builder: (context, _) => options.loginButtonBuilder(
                              context,
                              _handleLogin,
                              !_formValid.value,
                              () {
                                _formKey.currentState?.validate();
                              },
                              options,
                            ),
                          ),
                          if (widget.onRegister != null) ...[
                            options.registrationButtonBuilder(
                              context,
                              () async {
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
