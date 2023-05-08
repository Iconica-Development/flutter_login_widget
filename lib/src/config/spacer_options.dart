import 'package:flutter/material.dart';

@immutable
class LoginSpacerOptions {
  const LoginSpacerOptions({
    this.spacerAfterTitle,
    this.spacerAfterSubtitle,
    this.spacerAfterImage,
    this.spacerAfterForm,
    this.formFlexValue = 1,
  });

  /// Flex value for the spacer between the title and subtitle.
  final int? spacerAfterTitle;

  /// Flex value for the spacer between the subtitle and image.
  final int? spacerAfterSubtitle;

  /// Flex value for the spacer between the image and form.
  final int? spacerAfterImage;

  /// Flex value for the spacer between the form and button.
  final int? spacerAfterForm;

  /// Flex value for the form. Defaults to 1. Use this when also using the other spacer options.
  final int formFlexValue;
}
