import '../input.dart';

class PasswordValidator extends InputValidator<String> {
  PasswordValidator({
    required String errorMessage,
  }) : super(
          errorMessage: errorMessage,
          validator: (value) {
            return !(value.length < 8);
          },
        );
}
