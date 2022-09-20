import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'input.dart';

abstract class TextInput extends Input<String> {
  const TextInput({
    super.key,
    this.value = '',
    List<InputValidator<String>> validators = const [],
    InputDecoration? decoration,
    OnInputChange<String>? onChange,
    String? title,
    String? description,
    this.inputAction,
    this.capitalization,
    this.keyboardType,
    this.textAlign,
    this.enableSuggestions,
    this.autoCorrect,
    this.obscureText,
    this.inputFormatters,
    this.minLines,
    this.maxLines,
    this.autofocus,
    this.onSubmitted,
  })  : _decoration = decoration,
        super(
            inputValidators: validators,
            onChange: onChange,
            title: title,
            description: description);
  final String value;
  final InputDecoration? _decoration;
  final TextInputAction? inputAction;
  final TextCapitalization? capitalization;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final bool? enableSuggestions;
  final bool? autoCorrect;
  final bool? obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final int? minLines;
  final int? maxLines;
  final bool? autofocus;
  final Function(String)? onSubmitted;

  @override
  State<StatefulWidget> createState() => TextFieldState(
        initialValue: value,
      );
}

class TextFieldState extends InputState<String> {
  TextFieldState({required String initialValue})
      : super(
          initialValue,
        );
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: value);
  }

  void _onChange() {
    value = _controller.text;

    widget.change(value, validate());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget is TextInput) {
      var widget = this.widget as TextInput;
      return GestureDetector(
          onTap: () {
            setState(requestFocus);
          },
          child: widget.createInputShell(
            context,
            error: createErrorLabel(),
            title: createTitle(),
            description: createDescription(),
            focused: focusNode.hasFocus,
            input: TextField(
              autofocus: widget.autofocus ?? false,
              controller: _controller,
              onChanged: (_) => _onChange(),
              focusNode: focusNode,
              decoration: (widget._decoration ?? const InputDecoration())
                  .copyWith(labelStyle: Theme.of(context).textTheme.overline),
              textInputAction: widget.inputAction,
              keyboardType: widget.keyboardType,
              maxLines: widget.maxLines ?? 1,
              minLines: widget.minLines,
              textAlign: widget.textAlign ?? TextAlign.start,
              inputFormatters: widget.inputFormatters,
              enableSuggestions: widget.enableSuggestions ?? true,
              autocorrect: widget.autoCorrect ?? true,
              obscureText: widget.obscureText ?? false,
              textCapitalization:
                  widget.capitalization ?? TextCapitalization.none,
              onSubmitted: widget.onSubmitted,
            ),
          ));
    } else {
      throw 'This can only be a TextField';
    }
  }
}
