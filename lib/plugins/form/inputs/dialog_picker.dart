import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login_view.dart';

abstract class DialogPickerInput<V> extends Input<V> {
  const DialogPickerInput({
    required this.value,
    required this.onPick,
    required this.format,
    List<InputValidator<V>> inputValidators = const [],
    OnInputChange<V>? onChange,
    String? title,
    String? description,
    super.key,
  }) : super(
          inputValidators: inputValidators,
          title: title,
          description: description,
          onChange: onChange,
        );

  final V value;
  final Future<V> Function(BuildContext context, V value) onPick;
  final String Function(BuildContext context, V value) format;

  @override
  State<StatefulWidget> createState() => DialogPickerInputState(
        initialValue: value,
        onPick: onPick,
        format: format,
      );
}

class DialogPickerInputState<V> extends InputState<V> {
  DialogPickerInputState({
    required V initialValue,
    required this.onPick,
    required this.format,
  }) : super(initialValue);
  final Future<V> Function(BuildContext context, V value) onPick;
  final String Function(BuildContext context, V value) format;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.text = format.call(context, value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.createInputShell(
      context,
      input: buildDateTimePickerButton(context),
      error: createErrorLabel(),
      title: createTitle(),
      description: createDescription(),
      focused: focusNode.hasFocus,
    );
  }

  Widget buildDateTimePickerButton(BuildContext context) {
    return TextField(
      controller: _controller,
      showCursor: false,
      readOnly: true,
      decoration: InputDecoration(
        suffixIcon: context.login().config.appTheme.buttons.iconButton(
              context: context,
              onPressed: () async {
                var result = await onPick.call(context, value);
                setState(() {
                  value = result;
                  _controller.text = format.call(context, value);
                  widget.change(value, validate());
                });
              },
              icon: Icon(
                context.login().config.appTheme.icons.dateTimePicker,
                size: 30,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
      ),
    );
  }
}
