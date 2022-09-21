import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../flutter_login_view.dart';

class UserService extends ChangeNotifier {
  late Map<String, dynamic>? _currentProfile = {};

  set profile(Map<String, dynamic> profile) {
    _currentProfile = profile;
    notifyListeners();
  }

  Future<void> checkAutoLogin(FlutterLogin login) async {
    debugPrint('checking autologin');
    if (login.config.loginOptions.loginMode != LoginMode.NoLogin) {
      await Future.delayed(const Duration(milliseconds: 100), () async {
        if (login.config.loginOptions.loginMode == LoginMode.LoginAutomatic) {
          if (login.config.loginOptions.loginEmail == null ||
              login.config.loginOptions.loginEmail == '') {
            throw Exception('No login account for automatic login provided!');
          }
          if (login.config.loginOptions.loginPassword == null ||
              login.config.loginOptions.loginPassword == '') {
            throw Exception(
              'No login password for automatic login provided!',
            );
          }
          await login.repository.login(login.config.loginOptions.loginEmail!,
              login.config.loginOptions.loginPassword!);
        } else if (login.config.loginOptions.loginMode ==
            LoginMode.LoginAnonymous) {
          await login.repository.signInAnonymous();
        } else {
          var prefs = await SharedPreferences.getInstance();
          var autoLoginMode = login.config.loginOptions.autoLoginMode;
          if ((autoLoginMode != AutoLoginMode.alwaysOff &&
                  (prefs.getBool('autoLogin') ?? false) == true) ||
              autoLoginMode == AutoLoginMode.alwaysOn) {
            await login.repository.reLogin();
          }
        }
      });
    }
  }

  void addProfileListener(
    void Function(Map<String, dynamic>) onProfileChanged,
  ) {
    addListener(() {
      onProfileChanged.call(_currentProfile!);
    });
  }

  bool isLoggedIn(BuildContext context) =>
      context.loginRepository().isLoggedIn();

  Future<void> logout(BuildContext context) =>
      SharedPreferences.getInstance().then(
        (value) {
          value
              .setBool('autoLogin', false)
              .then((value) => context.loginRepository().logout());
        },
      );
}

class UserProfile {
  late Map<String, dynamic> rawFields;
  String? photoUrl;

  @mustCallSuper
  void init(Map<String, dynamic> raw) {
    rawFields = raw;
    photoUrl = raw['photo'];
  }

  bool isProfileComplete({List<String> requiredFields = const []}) {
    return !requiredFields.any((element) => rawFields[element] == null);
  }

  dynamic getValue(String key) {
    return rawFields[key];
  }
}
