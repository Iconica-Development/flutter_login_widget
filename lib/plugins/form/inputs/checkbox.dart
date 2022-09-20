import 'package:flutter/material.dart';
import 'input.dart';

abstract class CheckBox extends Input<bool> {
  const CheckBox({
    super.key,
    this.value = false,
    String? title,
    String? description,
    OnInputChange<bool>? onChange,
    List<InputValidator<bool>> inputValidators = const [],
  }) : super(
          inputValidators: inputValidators,
          description: description,
          title: title,
          onChange: onChange,
        );
  final bool value;

  @override
  InputState<bool> createState() => CheckBoxState(value);
}

class CheckBoxState extends InputState<bool> {
  CheckBoxState(bool initialValue) : super(initialValue);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        requestFocus();
        setState(
          () {
            value = !value;
          },
        );
        widget.change(value, validate());
      },
      child: widget.createInputShell(
        context,
        input: Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: Theme.of(context).colorScheme.secondary,
          ),
          child: Checkbox(
            value: value,
            focusNode: focusNode,
            onChanged: (value) {
              setState(
                () {
                  this.value = value ?? false;
                },
              );
              widget.change(
                this.value,
                validate(),
              );
            },
          ),
        ),
        error: createErrorLabel(),
        title: createTitle(),
        description: createDescription(),
        focused: focusNode.hasFocus,
      ),
    );
  }
}
