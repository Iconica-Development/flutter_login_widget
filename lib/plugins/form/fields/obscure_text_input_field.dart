import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login_view.dart';

class ObscureTextInputField extends StatefulWidget {
  const ObscureTextInputField({
    super.key,
    this.title,
    this.onChange,
    this.validators,
    this.value,
    this.onSubmitted,
  });

  final String? title;
  final void Function(String, bool)? onChange;
  final List<InputValidator<String>>? validators;
  final Function(String)? onSubmitted;
  final String? value;

  @override
  State<StatefulWidget> createState() {
    return ObscureTextInputFieldState();
  }
}

class ObscureTextInputFieldState extends State<ObscureTextInputField> {
  bool showText = true;

  @override
  Widget build(BuildContext context) {
    return context.login().config.appTheme.inputs.textField(
          onSubmitted: widget.onSubmitted,
          value: widget.value ?? '',
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () => setState(() {
                showText = !showText;
              }),
              icon: Icon(
                showText
                    ? context.login().config.appTheme.icons.passwordHidden
                    : context.login().config.appTheme.icons.passwordVisible,
                color: Theme.of(context)
                    .inputDecorationTheme
                    .border
                    ?.borderSide
                    .color,
              ),
            ),
          ),
          title: widget.title,
          obscureText: showText,
          onChange: widget.onChange,
          validators: widget.validators ?? [],
        );
  }
}
