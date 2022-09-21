import 'sdk/screen.dart';
import 'sdk/user.dart';

mixin FlutterLoginSdk {
  static final UserService _userService = UserService();
  static final ScreenService _screenService = ScreenService();

  UserService get users => _userService;
  ScreenService get screens => _screenService;

  static UserService get userService => _userService;
  static ScreenService get screenService => _screenService;

  void dispose() {
    _userService.dispose();
  }
}
