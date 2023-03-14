[![pub package](https://img.shields.io/pub/v/flutter_introduction_widget.svg)](https://github.com/Iconica-Development) [![Build status](https://img.shields.io/github/workflow/status/Iconica-Development/flutter_login_widget/CI)](https://github.com/Iconica-Development/flutter_login_widget/actions/new) [![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://github.com/tenhobi/effective_dart) 

# Login Widget
A package facilitating the basic ingredients for creating functional yet customizable login pages

[Login GIF](flutter_login.gif)

## Setup

To use this package, add `flutter_login` as a dependency in your pubspec.yaml file.

## How to use

```dart
final loginOptions = LoginOptions(
  emailDecoration: const InputDecoration(
    prefixIcon: Icon(Icons.email),
    border: OutlineInputBorder(),
  ),
  passwordDecoration: const InputDecoration(
    prefixIcon: Icon(Icons.password),
    border: OutlineInputBorder(),
  ),
  title: const Text('Login'),
  image: const FlutterLogo(),
  requestForgotPasswordButtonBuilder: (context, onPressed, isDisabled) {
    return Opacity(
      opacity: isDisabled ? 0.5 : 1.0,
      child: ElevatedButton(
        onPressed: onPressed,
        child: const Text('Send request'),
      ),
    );
  },
);

class LoginExample extends StatelessWidget {
  const LoginExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EmailPasswordLoginForm(
        options: loginOptions,
        onLogin: (email, password) => print('$email:$password'),
        onRegister: (email, password) => print('Register!'),
        onForgotPassword: (email) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const ForgotPasswordScreen();
              },
            ),
          );
        },
      ),
    );
  }
}

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ForgotPasswordForm(
        options: loginOptions,
        title: Text('Forgot password'),
        description: Text('Hello world'),
        onRequestForgotPassword: (email) {
          print('Forgot password email sent to $email');
        },
      ),
    );
  }
}

```

See the [Example Code](example/lib/main.dart) for an example on how to use this package.

## Issues

Please file any issues, bugs or feature request as an issue on our [GitHub](https://github.com/Iconica-Development/flutter_login_widget) page. Commercial support is available if you need help with integration with your app or services. You can contact us at [support@iconica.nl](mailto:support@iconica.nl).

## Want to contribute

If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](./CONTRIBUTING.md) and send us your [pull request](https://github.com/Iconica-Development/flutter_login_widget/pulls).

## Author

This `flutter_login_widget` for Flutter is developed by [Iconica](https://iconica.nl). You can contact us at <support@iconica.nl>