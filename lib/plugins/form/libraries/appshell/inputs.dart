import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as s;
import '../../form.dart';
import '../../inputs/checkbox.dart';
import '../../inputs/dialog_picker.dart';
import '../../inputs/dropdown.dart';
import '../../inputs/number_field.dart';
import '../../inputs/radio.dart';
import '../../inputs/range.dart';

class AppShellRadio<V> extends RadioInput<V> {
  const AppShellRadio({
    required V? value,
    required Map<V, String> entries,
    List<InputValidator<V>> inputValidators = const [],
    OnInputChange<V?>? onChange,
    String? title,
    String? description,
    super.key,
  }) : super(
          value: value,
          entries: entries,
          inputValidators: inputValidators,
          onChange: onChange,
          title: title,
          description: description,
        );

  @override
  Widget createInputShell(
    BuildContext context, {
    required Widget input,
    required Widget error,
    required Widget title,
    required Widget description,
    required bool focused,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        Row(
          children: [
            Expanded(
              child: input,
            ),
          ],
        ),
        error,
        description,
      ],
    );
  }
}

class AppShellDropDown<V> extends DropDownInput<V> {
  AppShellDropDown({
    required V? value,
    required Map<V, String> entries,
    List<InputValidator<V>> inputValidators = const [],
    OnInputChange<V?>? onChange,
    this.decoration,
    String? title,
    String? description,
  }) : super(
          value: value,
          entries: entries,
          inputValidators: inputValidators,
          onChange: onChange,
          title: title,
          description: description,
        );
  final InputDecoration? decoration;

  @override
  Widget createInputShell(
    BuildContext context, {
    required Widget input,
    required Widget error,
    required Widget title,
    required Widget description,
    required bool focused,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: InputDecorator(
                  decoration: (decoration ?? const InputDecoration()).copyWith(
                    labelStyle: Theme.of(context).textTheme.overline,
                    labelText: this.title,
                  ),
                  child: input,
                ),
              ),
            ],
          ),
          error,
          description,
        ],
      );
}

class AppShellRangeInput extends RangeInput {
  const AppShellRangeInput({
    required double value,
    required double min,
    required double max,
    required double step,
    List<InputValidator<double>> inputValidators = const [],
    OnInputChange<double>? onChange,
    String? title,
    String? description,
    super.key,
  }) : super(
          value: value,
          min: min,
          max: max,
          step: step,
          inputValidators: inputValidators,
          onChange: onChange,
          title: title,
          description: description,
        );

  @override
  Widget createInputShell(
    BuildContext context, {
    required Widget input,
    required Widget error,
    required Widget title,
    required Widget description,
    required bool focused,
  }) =>
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  constraints: BoxConstraints(
                    minWidth: 0,
                    maxWidth: MediaQuery.of(context).size.width * 0.25,
                  ),
                  child: title,
                ),
                Expanded(
                  child: input,
                ),
              ],
            ),
            description,
            error
          ],
        ),
      );
}

class AppShellToggle extends Toggle {
  const AppShellToggle({
    bool value = false,
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
          value: value,
        );

  @override
  Widget createInputShell(
    BuildContext context, {
    required Widget input,
    required Widget error,
    required Widget title,
    required Widget description,
    required bool focused,
  }) =>
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                title,
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: input,
                  ),
                ),
              ],
            ),
            description,
            error
          ],
        ),
      );
}

class AppShellCheckBox extends CheckBox {
  AppShellCheckBox({
    bool value = false,
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
            value: value);

  @override
  Widget createInputShell(
    BuildContext context, {
    required Widget input,
    required Widget error,
    required Widget title,
    required Widget description,
    required bool focused,
  }) =>
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: title,
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: input,
                  ),
                ),
              ],
            ),
            description,
            error
          ],
        ),
      );
}

class AppShellNumberField extends NumberInput {
  AppShellNumberField({
    double value = 0,
    List<InputValidator<double>> validators = const [],
    InputDecoration? decoration,
    OnInputChange<double>? onChange,
    TextInputAction? inputAction,
    TextCapitalization? capitalization,
    TextInputType? keyboardType,
    TextAlign? textAlign,
    NumberInputType? inputType,
    bool? enableSuggestions,
    bool? autoCorrect,
    bool? obscureText,
    String? description,
    String? title,
    double? min,
    double? max,
    super.key,
    List<s.TextInputFormatter>? inputFormatters,
  }) : super(
          value: value,
          validators: validators,
          onChange: onChange,
          inputAction: inputAction,
          keyboardType: keyboardType,
          decoration: (decoration ?? const InputDecoration())
              .copyWith(labelText: title),
          capitalization: capitalization,
          textAlign: textAlign,
          inputType: inputType ?? NumberInputType.Double,
          inputFormatters: inputFormatters,
          enableSuggestions: enableSuggestions,
          autoCorrect: autoCorrect,
          obscureText: obscureText,
          title: title,
          description: description,
          min: min ?? value,
          max: max ?? double.infinity,
        );
  @override
  Widget createInputShell(
    BuildContext context, {
    required Widget input,
    required Widget error,
    required Widget title,
    required Widget description,
    required bool focused,
  }) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title,
          Row(
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.2,
                  minWidth: 0,
                ),
                child: description,
              ),
              Expanded(
                child: Container(
                  child: input,
                ),
              )
            ],
          ),
          error,
        ],
      ),
    );
  }
}

class AppShellTextField extends TextInput {
  AppShellTextField({
    String value = '',
    List<InputValidator<String>> validators = const [],
    InputDecoration? decoration,
    OnInputChange<String>? onChange,
    TextInputAction? inputAction,
    TextCapitalization? capitalization,
    TextInputType? keyboardType,
    TextAlign? textAlign,
    bool? enableSuggestions,
    bool? autoCorrect,
    bool? obscureText,
    String? description,
    String? title,
    int? minLines,
    int? maxLines,
    bool? autofocus,
    Function(String)? onSubmitted,
    super.key,
    List<s.TextInputFormatter>? inputFormatters,
  }) : super(
          value: value,
          validators: validators,
          onChange: onChange,
          inputAction: inputAction,
          keyboardType: keyboardType,
          decoration: (decoration ?? const InputDecoration())
              .copyWith(labelText: title),
          capitalization: capitalization,
          textAlign: textAlign,
          enableSuggestions: enableSuggestions,
          inputFormatters: inputFormatters,
          autoCorrect: autoCorrect,
          obscureText: obscureText,
          title: title,
          description: description,
          minLines: minLines,
          maxLines: maxLines,
          autofocus: autofocus,
          onSubmitted: onSubmitted,
        );

  @override
  Widget createInputShell(
    BuildContext context, {
    required Widget input,
    required Widget error,
    required Widget title,
    required Widget description,
    required bool focused,
  }) =>
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.2,
                    minWidth: 0,
                  ),
                  child: description,
                ),
                Expanded(
                  child: input,
                ),
              ],
            ),
            error,
          ],
        ),
      );
}

class AppShellDialogPickerField<V> extends DialogPickerInput<V> {
  AppShellDialogPickerField({
    required V value,
    required Future<V> Function(BuildContext context, V value) onPick,
    required String Function(BuildContext context, V value) format,
    List<InputValidator<V>> inputValidators = const [],
    OnInputChange<V>? onChange,
    String? title,
    String? description,
  }) : super(
          value: value,
          onPick: onPick,
          format: format,
          inputValidators: inputValidators,
          onChange: onChange,
          title: title,
          description: description,
        );

  @override
  Widget createInputShell(
    BuildContext context, {
    required Widget input,
    required Widget error,
    required Widget title,
    required Widget description,
    required bool focused,
  }) =>
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.2,
                    minWidth: 0,
                  ),
                  child: description,
                ),
                Expanded(
                  child: input,
                ),
              ],
            ),
            error,
          ],
        ),
      );
}
