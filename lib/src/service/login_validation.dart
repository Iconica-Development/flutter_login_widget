import 'package:flutter_login/flutter_login.dart';

class LoginValidationService implements ValidationService {
  const LoginValidationService(this.options);

  final LoginOptions options;

  @override
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return options.translations.emailEmpty;
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return options.translations.emailInvalid;
    }
    return null;
  }

  @override
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return options.translations.passwordEmpty;
    }
    return null;
  }
}
