import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login_view.dart';

abstract class RadioInput<V> extends Input<V> {
  const RadioInput({
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
  State<StatefulWidget> createState() => RadioState(value, entries);
}

class RadioState<V> extends InputState<V> {
  RadioState(V initialValue, this.entries) : super(initialValue);
  final Map<V, String> entries;

  @override
  Widget build(BuildContext context) {
    return widget.createInputShell(
      context,
      input: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: entries
            .map((value, label) => MapEntry(
                value,
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: _radioButton(value, label, this.value == value),
                ))))
            .values
            .toList(),
      ),
      error: createErrorLabel(),
      title: createTitle(),
      description: createDescription(),
      focused: focusNode.hasFocus,
    );
  }

  Widget _radioButton(
    V value,
    String label,
    bool selected,
  ) {
    var color = selected
        ? Theme.of(context).colorScheme.secondary
        : Theme.of(context).buttonTheme.colorScheme?.primary ??
            Theme.of(context).primaryColor;

    return Theme(
      data: Theme.of(context).copyWith(
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
              colorScheme: Theme.of(context).buttonTheme.colorScheme?.copyWith(
                    primary: color,
                  ),
            ),
      ),
      child: Builder(
        builder: (context) {
          return context.appShell().config.appTheme.buttons.secondaryButton(
                context: context,
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: color,
                      fontWeight: selected
                          ? FontWeight.w900
                          : Theme.of(context).textTheme.bodyText1?.fontWeight),
                ),
                onPressed: () {
                  setState(() {
                    this.value = value;
                  });
                  widget.change(value, validate());
                  requestFocus();
                },
              );
        },
      ),
    );
  }
}
