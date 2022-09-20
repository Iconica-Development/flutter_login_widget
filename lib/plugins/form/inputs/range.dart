import 'dart:math';
import 'package:flutter/material.dart';
import 'input.dart';

abstract class RangeInput extends Input<double> {
  const RangeInput({
    required this.value,
    required this.min,
    required this.max,
    required this.step,
    List<InputValidator<double>> inputValidators = const [],
    OnInputChange<double>? onChange,
    String? title,
    String? description,
    super.key,
  }) : super(
            inputValidators: inputValidators,
            title: title,
            description: description,
            onChange: onChange);
  final double min;
  final double max;
  final double step;
  final double value;

  @override
  State<StatefulWidget> createState() => RangeInputState(
        initialValue: value,
        min: min,
        max: max,
        step: step,
      );
}

class RangeInputState extends InputState<double> {
  RangeInputState({
    required double initialValue,
    required this.min,
    required this.max,
    required this.step,
  }) : super(initialValue);
  final double min;
  final double max;
  final double step;

  double round(double value) {
    var decimals = ((max - min) / step).toString().split('.').last.length;
    var mod = pow(10.0, decimals);
    return (value * mod).round().toDouble() / mod;
  }

  @override
  Widget build(BuildContext context) {
    return widget.createInputShell(
      context,
      input: Slider(
        divisions: step.toInt(),
        value: value,
        label: '$value',
        onChanged: (value) {
          requestFocus();
          setState(() {
            this.value = round(value);
          });
        },
        onChangeEnd: (value) {
          widget.change(this.value.roundToDouble(), validate());
        },
        min: min,
        max: max,
      ),
      error: createErrorLabel(),
      title: createTitle(),
      description: createDescription(),
      focused: focusNode.hasFocus,
    );
  }
}
