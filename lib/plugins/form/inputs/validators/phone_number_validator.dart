import '../input.dart';

class PhoneNumberValidator extends InputValidator<String> {
  PhoneNumberValidator({required String errorMessage})
      : super(
          errorMessage: errorMessage,
          validator: (String value) =>
              RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value),
        );
}
