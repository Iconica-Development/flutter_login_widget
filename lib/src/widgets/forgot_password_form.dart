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
    var theme = Theme.of(context);
    var options = widget.options;

    return CustomScrollView(
      physics: const ScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          fillOverscroll: true,
          child: Column(
            children: [
              if (options.forgotPasswordSpacerOptions.spacerBeforeTitle !=
                  null) ...[
                Spacer(
                  flex: options.forgotPasswordSpacerOptions.spacerBeforeTitle!,
                ),
              ],
              Align(
                alignment: Alignment.topCenter,
                child: wrapWithDefaultStyle(
                  widget.title,
                  theme.textTheme.displaySmall,
                ),
              ),
              if (options.forgotPasswordSpacerOptions.spacerAfterTitle !=
                  null) ...[
                Spacer(
                  flex: options.forgotPasswordSpacerOptions.spacerAfterTitle!,
                ),
              ],
              Align(
                alignment: Alignment.topCenter,
                child: wrapWithDefaultStyle(
                  widget.description,
                  theme.textTheme.bodyMedium,
                ),
              ),
              if (options.forgotPasswordSpacerOptions.spacerAfterDescription !=
                  null) ...[
                Spacer(
                  flex: options
                      .forgotPasswordSpacerOptions.spacerAfterDescription!,
                ),
              ],
              Expanded(
                flex: options.forgotPasswordSpacerOptions.formFlexValue,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: options.maxFormWidth ?? 300,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Align(
                      alignment: Alignment.center,
                      child: options.emailInputContainerBuilder(
                        TextFormField(
                          textAlign: options.emailTextAlign ?? TextAlign.start,
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
      ],
    );
  }
}
