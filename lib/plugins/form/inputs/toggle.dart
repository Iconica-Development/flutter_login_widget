import 'package:flutter/material.dart';
import 'input.dart';

abstract class Toggle extends Input<bool> {
  const Toggle({
    this.value = false,
    String? title,
    String? description,
    OnInputChange<bool>? onChange,
    List<InputValidator<bool>> inputValidators = const [],
    super.key,
  }) : super(
          inputValidators: inputValidators,
          description: description,
          title: title,
          onChange: onChange,
        );
  final bool value;

  @override
  InputState<bool> createState() => ToggleState(value);
}

class ToggleState extends InputState<bool> {
  ToggleState(bool initialValue) : super(initialValue);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        requestFocus();
        setState(() {
          value = !value;
        });
        widget.change(
          value,
          validate(),
        );
      },
      child: widget.createInputShell(
        context,
        input: Switch(
          value: value,
          focusNode: focusNode,
          onChanged: (value) {
            setState(() {
              this.value = value;
            });
            widget.change(
              value,
              validate(),
            );
          },
        ),
        error: createErrorLabel(),
        title: createTitle(),
        description: createDescription(),
        focused: focusNode.hasFocus,
      ),
    );
  }
}
