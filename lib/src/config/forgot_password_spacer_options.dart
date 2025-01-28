import "package:flutter/material.dart";

@immutable

/// Options for configuring the spacer values for the forgot password form.
/// Use this to adjust the spacing between the title, description, textfield,
/// and button.
class ForgotPasswordSpacerOptions {
  /// Constructs a [ForgotPasswordSpacerOptions] widget.
  const ForgotPasswordSpacerOptions({
    this.spacerBeforeTitle,
    this.spacerAfterTitle,
    this.spacerAfterDescription,
    this.spacerBeforeButton,
    this.spacerAfterButton,
    this.formFlexValue = 1,
  });

  /// Flex value for the spacer before the title.
  final int? spacerBeforeTitle;

  /// Flex value for the spacer between the title and subtitle.
  final int? spacerAfterTitle;

  /// Flex value for the spacer between the description and the textfield.
  final int? spacerAfterDescription;

  /// Flex value for the spacer before the button.
  final int? spacerBeforeButton;

  /// Flex value for the spacer after the button.
  final int? spacerAfterButton;

  /// Flex value for the form. Defaults to 1. Use this when also using the
  /// other spacer options.
  final int formFlexValue;
}
