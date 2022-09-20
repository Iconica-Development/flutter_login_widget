library settings_page;

import 'package:flutter/material.dart';
import '../form/inputs/input.dart';

/// The settings are saved to shared preferences. Use the key you set to extract
/// the value of the settings.
///
/// prefs.getInt('KEY_HERE');
///
/// The types you need to extract the value of the ControlsTypes are:
/// DropDown int
/// Radio int
/// Checkbox String
/// String String
/// Number int
/// Toggle bool
/// Range double
/// TextField String
enum ControlType {
  DropDown,
  Radio,
  CheckBox,
  Number,
  Toggle,
  Range,
  Group,
  TextField,
  Page,
  Date,
  Time,
  DateRange,
  Custom
}

class Control extends ChangeNotifier {
  Control({
    required this.key,
    required this.type,
    this.condition,
    this.content,
    this.description,
    this.onChange,
    this.settings,
    this.title,
    this.value,
    this.keyboardType,
    this.validators,
    this.isRequired = true,
  });
  factory Control.dateRange({
    required String key,
    String? title,
    String? description,
    dynamic condition,
    void Function(dynamic)? onChange,
    DateTimeRange? value,
    DateTime? min,
    DateTime? max,
  }) =>
      Control(
        key: key,
        type: ControlType.DateRange,
        title: title,
        description: description,
        condition: condition,
        onChange: onChange,
        value: <String, DateTime?>{
          'selected-start': value?.start ?? DateTime.now(),
          'selected-end': value?.end ??
              DateTime.now().add(
                const Duration(days: 1),
              ),
          'min': min ?? value?.start ?? DateTime.now(),
          'max': max ??
              (min ?? value?.start ?? DateTime.now()).add(
                const Duration(days: 365),
              ),
        },
      );

  factory Control.time({
    required String key,
    String? title,
    String? description,
    dynamic condition,
    void Function(dynamic)? onChange,
    TimeOfDay? value,
  }) =>
      Control(
        key: key,
        type: ControlType.Time,
        title: title,
        description: description,
        condition: condition,
        onChange: onChange,
        value: value ?? TimeOfDay.now(),
      );

  factory Control.date({
    required String key,
    String? title,
    String? description,
    dynamic condition,
    void Function(dynamic)? onChange,
    DateTime? value,
    DateTime? min,
    DateTime? max,
  }) =>
      Control(
        key: key,
        type: ControlType.Date,
        title: title,
        description: description,
        condition: condition,
        onChange: onChange,
        value: <String, DateTime?>{
          'selected': value ?? DateTime.now(),
          'min': min ??
              value ??
              DateTime(DateTime.fromMillisecondsSinceEpoch(0).year - 100),
          'max': max ??
              (min ??
                  value ??
                  DateTime(
                    DateTime.fromMillisecondsSinceEpoch(0).year + 100,
                  )),
        },
      );

  factory Control.number({
    String? description,
    required String key,
    String? title,
    dynamic condition,
    void Function(dynamic)? onChange,
    double? value,
    double? max,
    double? min,
  }) =>
      Control(
          title: title ?? '',
          description: description ?? '',
          condition: condition,
          onChange: onChange,
          key: key,
          type: ControlType.Number,
          value: <String, double>{
            'selected': value ?? min ?? 0.0,
            'min': min ?? -double.maxFinite,
            'max': max ?? double.maxFinite,
          });

  factory Control.checkBox({
    String? description,
    required String key,
    String? title,
    dynamic condition,
    void Function(dynamic)? onChange,
    bool? value,
  }) =>
      Control(
        title: title ?? '',
        description: description,
        condition: condition,
        value: value ?? false,
        onChange: onChange,
        key: key,
        type: ControlType.CheckBox,
      );

  factory Control.toggle({
    required String key,
    String? description,
    String? title,
    dynamic condition,
    void Function(dynamic)? onChange,
    bool? value,
  }) =>
      Control(
        title: title ?? '',
        description: description,
        condition: condition,
        value: value ?? false,
        onChange: onChange,
        key: key,
        type: ControlType.Toggle,
      );

  factory Control.range({
    required double min,
    required double max,
    required double value,
    required String key,
    String? title,
    String? description,
    void Function(dynamic)? onChange,
    double? step,
    dynamic condition,
  }) {
    assert(min < max);
    assert(value >= min);
    assert(value <= max);
    return Control(
      value: <String, double>{
        'min': min,
        'max': max,
        'selected': value,
        'step': step ?? 100.0,
      },
      onChange: onChange,
      key: key,
      title: title,
      description: description,
      condition: condition,
      type: ControlType.Range,
    );
  }

  factory Control.dropDown({
    required List<String> items,
    required String key,
    String? description,
    String? title,
    int? selected,
    void Function(dynamic)? onChange,
    dynamic condition,
  }) {
    if (selected != null) {
      assert(selected < items.length);
      assert(selected >= 0);
    }
    return Control(
        value: {'items': items, 'selected': selected},
        type: ControlType.DropDown,
        title: title ?? '',
        description: description,
        onChange: onChange,
        condition: condition,
        key: key);
  }

  factory Control.radio({
    required List<String> options,
    required String key,
    String? description,
    String? title,
    int? selected,
    void Function(dynamic)? onChange,
    dynamic condition,
  }) {
    if (selected != null) {
      assert(selected < options.length);
      assert(selected >= 0);
    }
    return Control(
        value: {'options': options, 'selected': selected},
        type: ControlType.Radio,
        title: title ?? '',
        description: description,
        condition: condition,
        onChange: onChange,
        key: key);
  }

  factory Control.page({
    required List<Control> controls,
    required String title,
    dynamic condition,
    IconData? iconData,
  }) =>
      Control(
        type: ControlType.Page,
        key: 'page_$title',
        condition: condition,
        title: title,
        settings: controls,
        value: {
          'icon': iconData,
        },
      );

  factory Control.group({
    required List<Control> settings,
    dynamic condition,
    String? title,
  }) =>
      Control(
        type: ControlType.Group,
        key: 'group_$title',
        settings: settings,
        condition: condition,
        title: title ?? '',
      );

  factory Control.textField({
    required String key,
    String? title,
    String? description,
    Widget? content,
    void Function(dynamic)? onChange,
    dynamic condition,
    String? defaultValue,
    TextInputType? keyboardType,
    List<InputValidator<String>>? validators,
    bool isRequired = false,
  }) =>
      Control(
        description: description,
        title: title ?? '',
        type: ControlType.TextField,
        key: key,
        content: content,
        onChange: onChange,
        condition: condition,
        value: defaultValue,
        keyboardType: keyboardType,
        validators: validators,
        isRequired: isRequired,
      );

  /// The condition has to be either a String or a bool.
  /// If the condition is a bool and is true the setting will be shown. If the condition is
  /// a String the Control will be shown if the corresponding value of the String
  /// in the shared preferences returns true.
  dynamic condition;

  /// The value is the defaultvalue along with the items or options depending on whether the ControlType
  /// requires items or options to be given. If the ControlType is a bool the value should also be a bool.
  /// If the ControlsType is a DropDown the value should be a MapR containing the
  /// int selected and the items in the form of a List with Strings. If the ControlType
  /// is a Radio the value should be a Map containing int selected and List<String> options. If
  /// the ControlType is range the Map should contain max, min and selected. All three are
  /// doubles.
  dynamic value;

  /// This method is invoked everytime the user changes the setting
  void Function(dynamic)? onChange;

  /// The settings is a List containing the Controls that are shown grouped together
  /// inside a Container. The settings should only be used if the ControlType is Group.
  List<Control>? settings;

  /// The type is the type of Control. To see all the options see ControlType.
  ControlType type;

  /// The description is shown next to the setting
  String? description;

  /// The key is used to store the value in the shared preferences
  /// Hover over ControlsType to see how to extract the value from the shared preferences
  String key;

  /// The title is shown above the Control
  String? title;

  /// This is an optional param. You should either set content or other params but not
  /// both. If content is not null the content is shown instead of the ControlType.
  Widget? content;

  /// The keyboardType (used for textFields)
  TextInputType? keyboardType;

  /// Fields can be validated by one or multiple validators with custom error messages. (used for textFields)
  List<InputValidator<String>>? validators;

  /// Specify if the field is required when shown on registration pages (used for textFields)
  bool isRequired;

  void change(dynamic value) {
    onChange?.call(value);
    notifyListeners();
  }

  dynamic getValue() {
    if (value is Map) {
      if ((value as Map).containsKey('selected-start') &&
          (value as Map).containsKey('selected-end')) {
        return <DateTime>[value['selected-start'], value['selected-end']];
      } else {
        return value['selected'];
      }
    } else {
      return value;
    }
  }

  void clear() {
    if (value is Map) {
      if ((value as Map).containsKey('selected-start') &&
          (value as Map).containsKey('selected-end')) {
        value['selected-start'] = null;
        value['selected-end'] = null;
      } else {
        if (value['selected'] is double) {
          value['selected'] = 0.0;
        } else {
          value['selected'] = null;
        }
      }
    } else {
      value = null;
    }
  }
}
