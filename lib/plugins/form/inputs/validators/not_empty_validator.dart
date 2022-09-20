import '../input.dart';

class NotEmptyValidator extends InputValidator<String> {
  NotEmptyValidator({
    required String errorMessage,
  }) : super(
          errorMessage: errorMessage,
          validator: (value) => value.isNotEmpty,
        );
}
