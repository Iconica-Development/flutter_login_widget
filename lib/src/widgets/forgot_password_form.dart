import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({
    super.key,
    required this.options,
    required this.description,
    required this.onRequestForgotPassword,
    this.title,
    this.initialEmail,
  });

  final LoginOptions options;

  final Widget? title;
  final Widget description;
  final String? initialEmail;

  final FutureOr<void> Function(String email) onRequestForgotPassword;

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    _currentEmail = widget.initialEmail ?? widget.options.initialEmail;
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  final ValueNotifier<bool> _formValid = ValueNotifier(false);

  String _currentEmail = '';

  void _updateCurrentEmail(String email) {
    _currentEmail = email;
    _validate();
  }

  void _validate() {
    late bool isValid =
        widget.options.validations.validateEmail(_currentEmail) == null;
    if (isValid != _formValid.value) {
      _formValid.value = isValid;
    }
  }

  @override
  Widget build(BuildContext context) {
    var options = widget.options;
    var theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 16,
            ),
            child: _wrapWithDefaultStyle(
              widget.title,
              theme.textTheme.displaySmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 16,
            ),
            child: _wrapWithDefaultStyle(
              widget.description,
              theme.textTheme.bodyMedium,
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
              child: options.emailInputContainerBuilder(
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 300,
                    ),
                    child: TextFormField(
                      focusNode: _focusNode,
                      onChanged: _updateCurrentEmail,
                      validator: widget.options.validations.validateEmail,
                      initialValue: options.initialEmail,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: options.decoration.copyWith(
                        prefixIcon: options.emailInputPrefix,
                        label: options.emailLabel,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: _formValid,
              builder: (context, snapshot) {
                return Align(
                  child: widget.options.requestForgotPasswordButtonBuilder(
                    context,
                    () {
                      _formKey.currentState?.validate();
                      if (_formValid.value) {
                        widget.onRequestForgotPassword(_currentEmail);
                      }
                    },
                    !_formValid.value,
                    () {
                      _formKey.currentState?.validate();
                    },
                    options,
                  ),
                );
              },
            ),
          ),
        ],
      ),
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
