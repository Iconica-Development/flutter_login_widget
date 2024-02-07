import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class MFAWidget extends StatefulWidget {
  const MFAWidget({
    required this.onCompleted,
    this.onSubmitted,
    this.defaultPinTheme,
    this.focusedPinTheme,
    this.submittedPinTheme,
    this.followingPinTheme,
    this.disabledPinTheme,
    this.errorPinTheme,
    this.seperatorPositions,
    this.errorBuilder,
    this.errorText,
    this.errorTextStyle,
    this.validator,
    this.submitButtonBuilder,
    this.length = 6,
    super.key,
  }) : assert(
          (onSubmitted == null && submitButtonBuilder == null) ||
              (onSubmitted != null && submitButtonBuilder != null),
          'onSubmitted and submitButtonBuilder must be both null or both'
          ' not null',
        );

  final Function(String code) onCompleted;
  final Function(String code)? onSubmitted;
  final int length;
  final PinTheme? defaultPinTheme;
  final PinTheme? focusedPinTheme;
  final PinTheme? submittedPinTheme;
  final PinTheme? followingPinTheme;
  final PinTheme? disabledPinTheme;
  final PinTheme? errorPinTheme;
  final List<int>? seperatorPositions;
  final String? errorText;
  final String? Function(String?)? validator;
  final Widget Function(String?, String)? errorBuilder;
  final TextStyle? errorTextStyle;
  final Widget Function(Function onTap)? submitButtonBuilder;

  @override
  State<MFAWidget> createState() => _MFAWidgetState();
}

class _MFAWidgetState extends State<MFAWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Pinput(
            defaultPinTheme: widget.defaultPinTheme,
            focusedPinTheme: widget.focusedPinTheme,
            submittedPinTheme: widget.submittedPinTheme,
            followingPinTheme: widget.followingPinTheme,
            disabledPinTheme: widget.disabledPinTheme,
            errorPinTheme: widget.errorPinTheme,
            separatorPositions: widget.seperatorPositions,
            errorBuilder: widget.errorBuilder,
            errorText: widget.errorText,
            errorTextStyle: widget.errorTextStyle,
            validator: widget.validator,
            controller: _controller,
            length: widget.length,
            onCompleted: (_) {
              widget.onCompleted(_controller.text);
            },
          ),
          if (widget.onSubmitted != null &&
              widget.submitButtonBuilder != null) ...[
            widget.submitButtonBuilder!(() {
              widget.onSubmitted!(_controller.text);
            }),
          ],
        ],
      );
}
