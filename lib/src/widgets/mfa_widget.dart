import "package:flutter/material.dart";
import "package:pinput/pinput.dart";

class MFAWidget extends StatefulWidget {
  /// Constructs an [MFAWidget].
  ///
  /// [onCompleted]: Callback function triggered when the MFA code is completed.
  /// [onSubmitted]: Callback function triggered when the MFA code is submitted.
  /// [length]: The length of the MFA code.
  /// [defaultPinTheme]: The theme for the default state of the input pins.
  /// [focusedPinTheme]: The theme for the focused state of the input pins.
  /// [submittedPinTheme]: The theme for the submitted state of the input pins.
  /// [followingPinTheme]: The theme for the pins following the submitted pin.
  /// [disabledPinTheme]: The theme for disabled input pins.
  /// [errorPinTheme]: The theme for input pins in error state.
  /// [seperatorPositions]: Positions for separators between input pins.
  /// [errorText]: Text to display when there's an error.
  /// [validator]: Validator function to validate the input.
  /// [errorBuilder]: Builder function to customize the error display.
  /// [errorTextStyle]: Style for the error text.
  /// [submitButtonBuilder]: Builder function to customize the submit button.
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
          "onSubmitted and submitButtonBuilder must be both null or both"
          " not null",
        );

  /// Callback function triggered when the MFA code is completed.
  final Function(String code) onCompleted;

  /// Callback function triggered when the MFA code is submitted.
  final Function(String code)? onSubmitted;

  /// The length of the MFA code.
  final int length;

  /// The theme for the default state of the input pins.
  final PinTheme? defaultPinTheme;

  /// The theme for the focused state of the input pins.
  final PinTheme? focusedPinTheme;

  /// The theme for the submitted state of the input pins.
  final PinTheme? submittedPinTheme;

  /// The theme for the pins following the submitted pin.
  final PinTheme? followingPinTheme;

  /// The theme for disabled input pins.
  final PinTheme? disabledPinTheme;

  /// The theme for input pins in error state.
  final PinTheme? errorPinTheme;

  /// Positions for separators between input pins.
  final List<int>? seperatorPositions;

  /// Text to display when there's an error.
  final String? errorText;

  /// Validator function to validate the input.
  final String? Function(String?)? validator;

  /// Builder function to customize the error display.
  final Widget Function(String?, String)? errorBuilder;

  /// Style for the error text.
  final TextStyle? errorTextStyle;

  /// Builder function to customize the submit button.
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
