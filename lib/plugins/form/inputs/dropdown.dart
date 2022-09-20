import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login_view.dart';

abstract class DropDownInput<V> extends Input<V?> {
  const DropDownInput({
    required this.value,
    required this.entries,
    List<InputValidator<V>> inputValidators = const [],
    OnInputChange<V?>? onChange,
    String? title,
    String? description,
    super.key,
  }) : super(
          inputValidators: inputValidators,
          title: title,
          description: description,
          onChange: onChange,
        );

  final V? value;
  final Map<V, String> entries;

  @override
  State<StatefulWidget> createState() =>
      DropDownState(entries: entries, initialValue: value);
}

class DropDownState<V> extends InputState<V> {
  DropDownState({
    required this.entries,
    required V initialValue,
  }) : super(initialValue);
  final Map<V, String> entries;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: requestFocus,
      child: widget.createInputShell(
        context,
        input: DropdownButtonHideUnderline(
          child: DropdownButton<V>(
            selectedItemBuilder: (BuildContext context) {
              return entries
                  .map(
                    (value, text) => MapEntry(
                      value,
                      DropdownMenuItem<V>(
                        value: value,
                        child: Text(
                          context.translate(text),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    ),
                  )
                  .values
                  .toList();
            },
            value: value,
            isDense: true,
            isExpanded: true,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  this.value = value;
                });
                widget.change(value, validate());
              }
            },
            items: entries
                .map(
                  (value, text) => MapEntry(
                    value,
                    DropdownMenuItem<V>(
                      value: value,
                      child: Text(
                        context.translate(text),
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ),
                )
                .values
                .toList(),
            focusNode: focusNode,
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
