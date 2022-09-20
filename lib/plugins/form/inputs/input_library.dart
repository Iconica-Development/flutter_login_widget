import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as s;
import 'package:flutter_login/plugins/form/inputs/number_field.dart';
import 'package:flutter_login/plugins/form/inputs/radio.dart';
import 'package:flutter_login/plugins/form/inputs/range.dart';
import 'package:flutter_login/plugins/form/inputs/textfield.dart';
import 'package:flutter_login/plugins/form/inputs/toggle.dart';
import './dialog_picker.dart';
import 'checkbox.dart';
import 'dropdown.dart';
import 'input.dart';
export './textfield.dart';
export './toggle.dart';

abstract class InputLibrary {
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
  });

  NumberInput numberField({
    double value = 0,
    List<InputValidator<double>> validators = const [],
    InputDecoration? decoration,
    OnInputChange<double>? onChange,
    TextInputAction? inputAction,
    TextCapitalization? capitalization,
    TextInputType? keyboardType,
    TextAlign? textAlign,
    NumberInputType? inputType,
    List<s.TextInputFormatter>? inputFormatters,
    bool? enableSuggestions,
    bool? autoCorrect,
    bool? obscureText,
    String? description,
    String? title,
    double? min,
    double? max,
  });

  Toggle toggle({
    bool value = false,
    String? title,
    String? description,
    OnInputChange<bool>? onChange,
    List<InputValidator<bool>> inputValidators = const [],
  });

  CheckBox checkBox({
    bool value = false,
    String? title,
    String? description,
    OnInputChange<bool>? onChange,
    List<InputValidator<bool>> inputValidators = const [],
  });

  RangeInput range({
    required double value,
    required double min,
    required double max,
    required double step,
    List<InputValidator<double>> inputValidators = const [],
    OnInputChange<double>? onChange,
    String? title,
    String? description,
  });

  DropDownInput<V> dropDown<V>({
    required V? value,
    required Map<V, String> entries,
    List<InputValidator<V>> inputValidators = const [],
    OnInputChange<V?>? onChange,
    InputDecoration? decoration,
    String? title,
    String? description,
  });

  RadioInput<V> radio<V>({
    required V? value,
    required Map<V, String> entries,
    List<InputValidator<V>> inputValidators = const [],
    OnInputChange<V?>? onChange,
    String? title,
    String? description,
  });

  DialogPickerInput<DateTime> date(
      {required DateTime value,
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
      String? description});
}
