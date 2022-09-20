import '../input.dart';

class EmailValidator extends InputValidator<String> {
  EmailValidator({required String errorMessage})
      : super(
          errorMessage: errorMessage,
          validator: (value) {
            return RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value);
          },
        );
}
