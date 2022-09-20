import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login_view.dart';

abstract class Input<V> extends StatefulWidget {
  const Input({
    this.inputValidators = const [],
    this.onChange,
    this.description,
    this.title,
    Key? key,
  }) : super(key: key);

  final List<InputValidator<V>> inputValidators;
  final OnInputChange<V>? onChange;
  final String? title;
  final String? description;

  Widget createInputShell(
    BuildContext context, {
    required Widget input,
    required Widget error,
    required Widget title,
    required Widget description,
    required bool focused,
  });

  void change(
    V value,
    bool valid,
  ) {
    onChange?.call(value, valid);
  }
}

abstract class InputState<V> extends State<Input<V>> {
  InputState(V initialValue) : value = initialValue;
  V value;
  String error = '';
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    if (focusNode.hasFocus) {
      FocusScope.of(context).unfocus();
    }
    focusNode.dispose();
    super.dispose();
  }

  bool validate() {
    error = widget.inputValidators.map((e) {
      if (!e.validate(value)) {
        return e.errorMessage;
      } else {
        return '';
      }
    }).firstWhere((element) => element != '', orElse: () => '');
    setState(() {});
    if (error == '') {
      return true;
    } else {
      return false;
    }
  }

  Widget createErrorLabel() {
    if (error != '') {
      return Text(
        context.translate(error),
        style: Theme.of(context)
            .textTheme
            .bodyText2
            ?.copyWith(color: Theme.of(context).errorColor),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget createTitle({TextAlign textAlign: TextAlign.start}) {
    if (widget.title != null) {
      return Text(
        context.translate(widget.title!),
        textAlign: textAlign,
        style: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(fontWeight: FontWeight.bold),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget createDescription() {
    if (widget.description != null && widget.description != '') {
      return Text(
        context.translate(widget.description!),
        style: Theme.of(context).textTheme.bodyText1,
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  void requestFocus() {
    if (!focusNode.hasFocus) {
      FocusScope.of(context).unfocus();
      focusNode.requestFocus();
    }
  }
}

class InputValidator<V> {
  InputValidator({required this.validator, required this.errorMessage});
  final ValidateInput<V> validator;
  final String errorMessage;

  bool validate(V value) {
    return validator.call(value);
  }
}

typedef ValidateInput<V> = bool Function(V value);
typedef OnInputChange<V> = void Function(V value, bool valid);
