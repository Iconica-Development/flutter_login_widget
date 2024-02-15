import 'package:flutter/material.dart';

@immutable
class LoginSpacerOptions {
  const LoginSpacerOptions({
    this.spacerBeforeTitle,
    this.spacerAfterTitle,
    this.spacerAfterSubtitle,
    this.spacerAfterImage,
    this.spacerAfterForm,
    this.spacerAfterButton,
    this.formFlexValue = 1,
    this.titleSpacer = 1,
  });

  /// Flex value for the spacer before the title.
  final int? spacerBeforeTitle;

  /// Flex value for the spacer between the title and subtitle.
  final int? spacerAfterTitle;

  /// Flex value for the spacer between the subtitle and image.
  final int? spacerAfterSubtitle;

  /// Flex value for the spacer between the image and form.
  final int? spacerAfterImage;

  /// Flex value for the spacer between the form and button.
  final int? spacerAfterForm;

  /// Flex value for the spacer after the button.
  final int? spacerAfterButton;

  /// Flex value for the form. Defaults to 1. Use this when also using the
  /// other spacer options.
  final int formFlexValue;

  final int titleSpacer;
}
