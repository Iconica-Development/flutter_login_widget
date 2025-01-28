import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_login/flutter_login.dart";

class EmailPasswordLoginForm extends StatefulWidget {
  /// Constructs an [EmailPasswordLoginForm] widget.
  ///
  /// [title]: The title to display above the form.
  /// [subtitle]: A subtitle to display below the title.
  /// [onLogin]: Callback function for user login.
  /// [onForgotPassword]: Callback function for when the user
  /// forgets their password.
  /// [onRegister]: Callback function for user registration.
  /// [options]: The options for configuring the login form.
  const EmailPasswordLoginForm({
    required this.onLogin,
    this.title,
    this.subtitle,
    this.onForgotPassword,
    this.onRegister,
    this.options = const LoginOptions(),
    super.key,
  });

  final LoginOptions options;

  final Widget? title;
  final Widget? subtitle;

  final void Function(String email, BuildContext ctx)? onForgotPassword;
  final FutureOr<void> Function(
    String email,
    String password,
    BuildContext context,
  )? onRegister;
  final FutureOr<void> Function(String email, String password) onLogin;

  @override
  State<EmailPasswordLoginForm> createState() => _EmailPasswordLoginFormState();
}

class _EmailPasswordLoginFormState extends State<EmailPasswordLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _formValid = ValueNotifier(false);
  bool _obscurePassword = true;

  String _currentEmail = "";
  String _currentPassword = "";

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
    var options = widget.options;

    var emailTextFormField = TextFormField(
      autofillHints: const [
        AutofillHints.email,
        AutofillHints.username,
      ],
      textAlign: options.emailTextAlign ?? TextAlign.start,
      onChanged: _updateCurrentEmail,
      validator: widget.options.validations.validateEmail,
      initialValue: options.initialEmail,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      style: options.emailTextStyle,
      decoration: options.emailDecoration,
    );

    var passwordTextFormField = TextFormField(
      autofillHints: const [
        AutofillHints.password,
      ],
      textAlign: options.passwordTextAlign ?? TextAlign.start,
      obscureText: _obscurePassword,
      onChanged: _updateCurrentPassword,
      validator: widget.options.validations.validatePassword,
      initialValue: options.initialPassword,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      style: options.passwordTextStyle,
      onFieldSubmitted: (_) async => _handleLogin(),
      decoration: options.passwordDecoration.copyWith(
        suffixIcon: options.showObscurePassword
            ? IconButton(
                padding: options.suffixIconPadding,
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  size: options.suffixIconSize,
                ),
              )
            : null,
      ),
    );

    var forgotPasswordButton = widget.onForgotPassword != null
        ? Align(
            alignment: Alignment.topRight,
            child: options.forgotPasswordButtonBuilder(
              context,
              () => widget.onForgotPassword?.call(_currentEmail, context),
              false,
              () {},
              options,
            ),
          )
        : const SizedBox(height: 16);

    var loginButton = AnimatedBuilder(
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
    );

    var registerButton = options.registrationButtonBuilder(
      context,
      () async {
        widget.onRegister?.call(
          _currentEmail,
          _currentPassword,
          context,
        );
      },
      false,
      () {},
      options,
    );

    return Scaffold(
      backgroundColor: options.loginBackgroundColor,
      body: CustomScrollView(
        physics: const ScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Column(
              children: [
                Expanded(
                  flex: options.spacers.titleSpacer,
                  child: LoginTitle(
                    options: options,
                    title: widget.title,
                    subtitle: widget.subtitle,
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
                      child: AutofillGroup(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            options.emailInputContainerBuilder(
                              emailTextFormField,
                            ),
                            options.passwordInputContainerBuilder(
                              passwordTextFormField,
                            ),
                            forgotPasswordButton,
                            if (options.spacers.spacerAfterForm != null) ...[
                              Spacer(flex: options.spacers.spacerAfterForm!),
                            ],
                            loginButton,
                            if (widget.onRegister != null) ...[
                              registerButton,
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
      ),
    );
  }
}

class LoginTitle extends StatelessWidget {
  const LoginTitle({
    required this.options,
    this.title,
    this.subtitle,
    super.key,
  });

  final LoginOptions options;
  final Widget? title;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: [
        if (options.spacers.spacerBeforeTitle != null) ...[
          Spacer(flex: options.spacers.spacerBeforeTitle!),
        ],
        if (title != null) ...[
          Align(
            alignment: Alignment.topCenter,
            child: wrapWithDefaultStyle(
              title,
              theme.textTheme.headlineSmall,
            ),
          ),
        ],
        if (options.spacers.spacerAfterTitle != null) ...[
          Spacer(flex: options.spacers.spacerAfterTitle!),
        ],
        if (subtitle != null) ...[
          Align(
            alignment: Alignment.topCenter,
            child: wrapWithDefaultStyle(
              subtitle,
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
    );
  }
}

Widget? wrapWithDefaultStyle(Widget? widget, TextStyle? style) {
  if (style == null || widget == null) {
    return widget;
  } else {
    return DefaultTextStyle(style: style, child: widget);
  }
}
