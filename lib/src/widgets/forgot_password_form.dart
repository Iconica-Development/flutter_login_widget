import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

class ForgotPasswordForm extends StatefulWidget {
  /// Constructs a [ForgotPasswordForm] widget.
  ///
  /// [options]: The options for configuring the forgot password form.
  /// [description]: Widget to display description.
  /// [onRequestForgotPassword]: Callback function for requesting
  /// password reset.
  /// [title]: Widget to display title.
  const ForgotPasswordForm({
    required this.options,
    required this.description,
    required this.onRequestForgotPassword,
    super.key,
    this.title,
  });

  final LoginOptions options;

  final Widget? title;
  final Widget description;

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
    _currentEmail = widget.options.initialEmail;
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
    late var isValid =
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
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 300,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (options.forgotPasswordSpacerOptions.spacerBeforeTitle !=
                null) ...[
              Spacer(
                flex: options.forgotPasswordSpacerOptions.spacerBeforeTitle!,
              ),
            ],
            _wrapWithDefaultStyle(
                  widget.title,
                  theme.textTheme.displaySmall,
                ) ??
                const SizedBox.shrink(),
            if (options.forgotPasswordSpacerOptions.spacerAfterTitle !=
                null) ...[
              Spacer(
                flex: options.forgotPasswordSpacerOptions.spacerAfterTitle!,
              ),
            ],
            _wrapWithDefaultStyle(
                  widget.description,
                  theme.textTheme.bodyMedium,
                ) ??
                const SizedBox.shrink(),
            if (options.forgotPasswordSpacerOptions.spacerAfterDescription !=
                null) ...[
              Spacer(
                flex:
                    options.forgotPasswordSpacerOptions.spacerAfterDescription!,
              ),
            ],
            Expanded(
              flex: options.forgotPasswordSpacerOptions.formFlexValue,
              child: Align(
                child: options.emailInputContainerBuilder(
                  TextFormField(
                    focusNode: _focusNode,
                    onChanged: _updateCurrentEmail,
                    validator: widget.options.validations.validateEmail,
                    initialValue: options.initialEmail,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    style: options.emailTextStyle,
                    decoration: options.emailDecoration,
                  ),
                ),
              ),
            ),
            if (options.forgotPasswordSpacerOptions.spacerBeforeButton !=
                null) ...[
              Spacer(
                flex: options.forgotPasswordSpacerOptions.spacerBeforeButton!,
              ),
            ],
            AnimatedBuilder(
              animation: _formValid,
              builder: (context, snapshot) => Align(
                child: widget.options.requestForgotPasswordButtonBuilder(
                  context,
                  () async {
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
              ),
            ),
            if (options.forgotPasswordSpacerOptions.spacerAfterButton !=
                null) ...[
              Spacer(
                flex: options.forgotPasswordSpacerOptions.spacerAfterButton!,
              ),
            ],
          ],
        ),
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
