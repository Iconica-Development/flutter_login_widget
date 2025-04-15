import "package:flutter/services.dart";
import "package:flutter_login/src/config/login_options.dart";
import "package:local_auth/local_auth.dart";

class LocalAuthService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<void> authenticate(LoginOptions loginOptions) async {
    var biometricsOptions = loginOptions.biometricsOptions;

    try {
      if (!await _localAuth.isDeviceSupported()) {
        biometricsOptions.onBiometricsError?.call();
        return;
      }
      var didAuthenticate = await _localAuth.authenticate(
        localizedReason: loginOptions.translations.biometricsLoginMessage,
        options: AuthenticationOptions(
          biometricOnly: !biometricsOptions.allowBiometricsAlternative,
          stickyAuth: true,
          sensitiveTransaction: false,
        ),
      );
      if (didAuthenticate) {
        biometricsOptions.onBiometricsSuccess?.call();
      }

      if (!didAuthenticate) {
        biometricsOptions.onBiometricsFail?.call();
      }
    } on PlatformException catch (_) {
      biometricsOptions.onBiometricsError?.call();
    }
  }
}
