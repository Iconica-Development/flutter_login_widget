import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as s;
import 'package:flutter_login/flutter_login_view.dart';
import 'package:intl/intl.dart' show DateFormat, Intl;
import '../../inputs/checkbox.dart';
import '../../inputs/dialog_picker.dart';
import '../../inputs/dropdown.dart';
import '../../inputs/number_field.dart';
import '../../inputs/radio.dart';
import '../../inputs/range.dart';
import 'inputs.dart';

class AppShellInputLibrary implements InputLibrary {
  const AppShellInputLibrary();

  @override
  TextInput textField({
    String value = '',
    List<InputValidator<String>> validators = const [],
    InputDecoration? decoration,
    OnInputChange<String>? onChange,
    TextInputAction? inputAction,
    TextCapitalization? capitalization,
    TextInputType? keyboardType,
    TextAlign? textAlign,
    List<s.TextInputFormatter>? inputFormatters,
    bool? enableSuggestions,
    bool? autoCorrect,
    bool? obscureText,
    String? description,
    String? title,
    int? minLines,
    int? maxLines,
    bool? autofocus,
    Function(String)? onSubmitted,
  }) =>
      AppShellTextField(
        value: value,
        onChange: onChange,
        validators: validators,
        inputAction: inputAction,
        decoration: decoration,
        keyboardType: keyboardType,
        capitalization: capitalization,
        textAlign: textAlign,
        inputFormatters: inputFormatters,
        enableSuggestions: enableSuggestions,
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
  NumberInput numberField({
    double value = 0,
    List<InputValidator<double>> validators = const [],
    InputDecoration? decoration,
    OnInputChange<double>? onChange,
    TextInputAction? inputAction,
    TextCapitalization? capitalization,
    TextInputType? keyboardType,
    TextAlign? textAlign,
    List<s.TextInputFormatter>? inputFormatters,
    NumberInputType? inputType,
    bool? enableSuggestions,
    bool? autoCorrect,
    bool? obscureText,
    String? description,
    String? title,
    double? min,
    double? max,
  }) =>
      AppShellNumberField(
        value: value,
        onChange: onChange,
        validators: validators,
        inputAction: inputAction,
        keyboardType: keyboardType,
        capitalization: capitalization,
        textAlign: textAlign,
        inputType: inputType,
        inputFormatters: inputFormatters,
        enableSuggestions: enableSuggestions,
        autoCorrect: autoCorrect,
        obscureText: obscureText,
        min: min,
        max: max,
        title: title,
        description: description,
      );

  @override
  Toggle toggle({
    bool value = false,
    String? title,
    String? description,
    OnInputChange<bool>? onChange,
    List<InputValidator<bool>> inputValidators = const [],
  }) {
    return AppShellToggle(
      inputValidators: inputValidators,
      description: description,
      title: title,
      onChange: onChange,
      value: value,
    );
  }

  @override
  CheckBox checkBox({
    bool value = false,
    String? title,
    String? description,
    OnInputChange<bool>? onChange,
    List<InputValidator<bool>> inputValidators = const [],
  }) {
    return AppShellCheckBox(
      inputValidators: inputValidators,
      description: description,
      title: title,
      onChange: onChange,
      value: value,
    );
  }

  @override
  RangeInput range({
    required double value,
    required double min,
    required double max,
    required double step,
    List<InputValidator<double>> inputValidators = const [],
    OnInputChange<double>? onChange,
    String? title,
    String? description,
  }) {
    return AppShellRangeInput(
      value: value,
      min: min,
      max: max,
      step: step,
      inputValidators: inputValidators,
      onChange: onChange,
      title: title,
      description: description,
    );
  }

  @override
  DropDownInput<V> dropDown<V>({
    required V? value,
    required Map<V, String> entries,
    List<InputValidator<V>> inputValidators = const [],
    OnInputChange<V?>? onChange,
    InputDecoration? decoration,
    String? title,
    String? description,
  }) =>
      AppShellDropDown(
        value: value,
        entries: entries,
        inputValidators: inputValidators,
        onChange: onChange,
        title: title,
        description: description,
        decoration: decoration,
      );

  @override
  RadioInput<V> radio<V>({
    required V? value,
    required Map<V, String> entries,
    List<InputValidator<V>> inputValidators = const [],
    OnInputChange<V?>? onChange,
    String? title,
    String? description,
  }) =>
      AppShellRadio(
        value: value,
        entries: entries,
        inputValidators: inputValidators,
        onChange: onChange,
        title: title,
        description: description,
      );

  @override
  DialogPickerInput<DateTime> date({
    required DateTime value,
    required DateTime firstDate,
    required DateTime lastDate,
    DateTime? currentDate,
    DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
    bool Function(DateTime)? selectableDayPredicate,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    TextDirection? textDirection,
    Widget Function(BuildContext, Widget?)? builder,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
    List<InputValidator<DateTime>> inputValidators = const [],
    OnInputChange<DateTime>? onChange,
    String? title,
    String? description,
  }) =>
      AppShellDialogPickerField(
        value: value,
        onPick: (BuildContext context, DateTime value) async {
          return await showDatePicker(
                context: context,
                initialDate: value,
                firstDate: firstDate,
                lastDate: lastDate,
                currentDate: currentDate,
                initialEntryMode: initialEntryMode,
                selectableDayPredicate: selectableDayPredicate,
                helpText: context
                    .translate('appshell_input_library.date.picker.help_text'),
                cancelText: context.translate(
                  'appshell_input_library.date.picker.cancel_text',
                ),
                confirmText: context.translate(
                  'appshell_input_library.date.picker.confirm_text',
                ),
                locale: Localizations.localeOf(context),
                useRootNavigator: useRootNavigator,
                routeSettings: routeSettings,
                textDirection: textDirection,
                builder: builder,
                initialDatePickerMode: initialDatePickerMode,
                errorFormatText: context.translate(
                  'appshell_input_library.date.picker.error_format_text',
                ),
                errorInvalidText: context.translate(
                  'appshell_input_library.date.picker.error_invalid_text',
                ),
                fieldLabelText: context.translate(
                  'appshell_input_library.date.picker.field_label_text',
                ),
              ) ??
              value;
        },
        format: (BuildContext context, DateTime value) =>
            DateFormat.yMd(Intl.systemLocale).format(value),
        inputValidators: inputValidators,
        onChange: onChange,
        title: title,
        description: description,
      );
}
