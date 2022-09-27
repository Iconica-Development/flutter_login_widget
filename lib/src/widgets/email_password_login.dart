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
  final VoidCallback? onForgotPassword;
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
    late bool isValid = _validateEmail(_currentEmail) == null &&
        _validatePassword(_currentPassword) == null;
    if (isValid != _formValid.value) {
      _formValid.value = isValid;
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return widget.options.translations.emailEmpty;
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return widget.options.translations.emailInvalid;
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return widget.options.translations.passwordEmpty;
    }
    return null;
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
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var options = widget.options;
    return Column(
      children: [
        if (options.title != null) ...[
          const SizedBox(
            height: 60,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: _wrapWithDefaultStyle(
              options.title,
              theme.textTheme.headline6,
            ),
          )
        ],
        if (options.subtitle != null) ...[
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: _wrapWithDefaultStyle(
              options.subtitle,
              theme.textTheme.subtitle1,
            ),
          )
        ],
        if (options.image != null) ...[
          Padding(
            padding: const EdgeInsets.all(16),
            child: options.image,
          ),
        ],
        Expanded(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 300,
            ),
            child: Form(
              key: _formKey,
              child: Align(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      onChanged: _updateCurrentEmail,
                      validator: _validateEmail,
                      initialValue: options.initialEmail,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: options.decoration.copyWith(
                        prefixIcon: options.emailInputPrefix,
                        label: options.emailLabel,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      obscureText: _obscurePassword,
                      onChanged: _updateCurrentPassword,
                      validator: _validatePassword,
                      initialValue: options.initialPassword,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _handleLogin(),
                      decoration: options.decoration.copyWith(
                        label: options.passwordLabel,
                        prefixIcon: options.passwordInputPrefix,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
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
                    const SizedBox(height: 24),
                    if (widget.onForgotPassword != null) ...[
                      Align(
                        alignment: Alignment.topRight,
                        child: options.forgotPasswordButtonBuilder(
                          context,
                          () {
                            widget.onForgotPassword?.call();
                          },
                          false,
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                    AnimatedBuilder(
                      animation: _formValid,
                      builder: (context, _) {
                        return options.loginButtonBuilder(
                          context,
                          _handleLogin,
                          !_formValid.value,
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
                      ),
                    ]
                  ],
                ),
              ),
            ),
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