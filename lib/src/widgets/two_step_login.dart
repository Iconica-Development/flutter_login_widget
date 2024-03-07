import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

class TwoStepLoginForm extends StatefulWidget {
  /// Constructs an [TwoStepLoginForm] widget.
  ///
  /// [onCheckEmail]: Callback function for when a user has filled in its email
  /// [options]: The options for configuring the login form.
  const TwoStepLoginForm({
    required this.onCheckEmail,
    super.key,
    this.options = const LoginOptions(),
  });

  final LoginOptions options;
  final FutureOr<void> Function(String email) onCheckEmail;
  @override
  State<TwoStepLoginForm> createState() => _TwoStepLoginFormState();
}

class _TwoStepLoginFormState extends State<TwoStepLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _formValid = ValueNotifier(false);
  bool _obscurePassword = true;

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

  Future<void> _handleLogin() async {
    if (mounted) {
      var form = _formKey.currentState!;
      if (form.validate()) {
        await widget.onCheckEmail(
          _currentEmail,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _currentEmail = widget.options.initialEmail;
    _validate();
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
              Expanded(
                flex: options.spacers.titleSpacer,
                child: Column(
                  children: [
                    if (options.spacers.spacerBeforeTitle != null) ...[
                      Spacer(flex: options.spacers.spacerBeforeTitle!),
                    ],
                    if (options.title != null) ...[
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
                  ],
                ),
              ),
              Expanded(
                flex: options.spacers.formFlexValue,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: options.maxFormWidth ?? 300,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        options.emailInputContainerBuilder(
                          TextFormField(
                            onChanged: _updateCurrentEmail,
                            validator: widget.options.validations.validateEmail,
                            initialValue: options.initialEmail,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            style: options.emailTextStyle,
                            decoration: options.emailDecoration,
                          ),
                        ),
                        if (options.spacers.spacerAfterForm != null) ...[
                          Spacer(flex: options.spacers.spacerAfterForm!),
                        ],
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
                        if (options.spacers.spacerAfterButton != null) ...[
                          Spacer(flex: options.spacers.spacerAfterButton!),
                        ],
                      ],
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
