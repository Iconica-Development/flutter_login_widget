import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'input.dart';

enum NumberInputType {
  Integer,
  Money,
  Double,

  /// this is the only type where no formatters are added to the field.
  Custom,
}

abstract class NumberInput extends Input<double> {
  NumberInput(
      {super.key,
      this.value = 0,
      List<InputValidator<double>> validators = const [],
      this.decoration,
      OnInputChange<double>? onChange,
      String? title,
      String? description,
      this.inputAction,
      this.capitalization,
      this.keyboardType,
      this.textAlign,
      this.enableSuggestions,
      this.autoCorrect,
      this.obscureText,
      double min = 0,
      double max = double.infinity,
      List<TextInputFormatter>? inputFormatters,
      this.inputType = NumberInputType.Double})
      : super(
          inputValidators: List.from(validators)
            ..add(
              InputValidator(
                validator: (value) {
                  return value >= min && value <= max;
                },
                errorMessage: 'messageBetweenMin${min}AndMax$max',
              ),
            ),
          onChange: onChange,
          title: title,
          description: description,
        ) {
    this.inputFormatters = inputFormatters ?? [];
    if (inputType != NumberInputType.Custom) {
      this.inputFormatters?.add(
            getInputFormatterForType(inputType),
          );
    }
  }
  final double value;
  final InputDecoration? decoration;
  final TextInputAction? inputAction;
  final TextCapitalization? capitalization;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  late final List<TextInputFormatter>? inputFormatters;
  final bool? enableSuggestions;
  final bool? autoCorrect;
  final bool? obscureText;
  final NumberInputType inputType;

  @override
  InputState<double> createState() => NumberInputState(
        initialValue: value,
        decoration: decoration,
        action: inputAction,
        keyboardType: keyboardType,
        capitalization: capitalization,
        inputFormatters: inputFormatters,
        align: textAlign,
        enableSuggestions: enableSuggestions,
        autoCorrect: autoCorrect,
        obscureText: obscureText,
        roundDecimals: getDecimalsForType(inputType),
      );

  TextInputFormatter getInputFormatterForType(NumberInputType inputType) {
    switch (inputType) {
      case NumberInputType.Double:
        return FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*$'));
      case NumberInputType.Integer:
        return FilteringTextInputFormatter.allow(RegExp('[d]'));
      case NumberInputType.Money:
        return FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*$'));
      case NumberInputType.Custom:
        break;
    }
    return FilteringTextInputFormatter.allow(RegExp(''));
  }

  int getDecimalsForType(NumberInputType inputType) {
    switch (inputType) {
      case NumberInputType.Double:
        return 6;
      case NumberInputType.Integer:
        return 0;
      case NumberInputType.Money:
        return 2;
      case NumberInputType.Custom:
        break;
    }
    return 1;
  }
}

class NumberInputState extends InputState<double> {
  NumberInputState({
    required double initialValue,
    required this.roundDecimals,
    this.decoration,
    this.action,
    this.keyboardType,
    this.capitalization,
    this.align,
    this.obscureText,
    this.autoCorrect,
    this.enableSuggestions,
    this.inputFormatters,
  }) : super(initialValue);
  late final TextEditingController _controller;
  final InputDecoration? decoration;
  final TextInputAction? action;
  final TextInputType? keyboardType;
  final TextCapitalization? capitalization;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign? align;
  final bool? enableSuggestions;
  final bool? autoCorrect;
  final bool? obscureText;
  final int roundDecimals;

  double change = 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: '${roundDecimals == 0 ? value.toInt() : value}');
  }

  void _onChange() {
    value = double.tryParse(_controller.text) ?? value;
    if (roundDecimals == 0) {
      value = value.floor().toDouble();
    } else {
      value = round(value);
    }
    widget.change(value, validate());
  }

  double round(double value) {
    var mod = pow(10.0, roundDecimals);
    return (value * mod).round().toDouble() / mod;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: requestFocus,
      onVerticalDragUpdate: (details) {
        change = (-details.localPosition.dy + 75) / 5;
        change = change.floor().toDouble();
        var changeValue = value + change;
        _controller.value = TextEditingValue(
          text:
              '${roundDecimals == 0 ? changeValue.toInt() : round(changeValue)}',
        );
      },
      onVerticalDragEnd: (details) {
        value = value + change;
        if (roundDecimals == 0) {
          value = value.floor().toDouble();
        } else {
          value = round(value);
        }
        change = 0;
        TextEditingValue(
            text: '${roundDecimals == 0 ? value.toInt() : round(value)}');
        widget.change(value, validate());
      },
      child: widget.createInputShell(
        context,
        input: TextField(
          controller: _controller,
          onChanged: (_) => _onChange(),
          focusNode: focusNode,
          decoration: (decoration ?? const InputDecoration())
              .copyWith(labelStyle: Theme.of(context).textTheme.overline),
          textInputAction: action,
          keyboardType: keyboardType ??
              TextInputType.numberWithOptions(
                decimal: roundDecimals > 0,
              ),
          textAlign: align ?? TextAlign.start,
          inputFormatters: inputFormatters,
          enableSuggestions: enableSuggestions ?? true,
          autocorrect: autoCorrect ?? true,
          obscureText: obscureText ?? false,
          textCapitalization: capitalization ?? TextCapitalization.none,
        ),
        error: createErrorLabel(),
        title: createTitle(),
        description: createDescription(),
        focused: focusNode.hasPrimaryFocus,
      ),
    );
  }
}
