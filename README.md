A package facilitating the basic ingredients for creating functional yet customizable login pages

## Features

Create a login screen for email and password logins
Create a forgot password screen by passing in the email from the login

## Getting started

1. install the package by adding the following to your pubspec.yaml
   ```
    flutter_login:
      git:
        url: https://github.com/Iconica-Development/flutter_login.git
        ref: 1.0.0
   ```

## Usage

```dart
final loginOptions = LoginOptions(
  decoration: const InputDecoration(
    border: OutlineInputBorder(),
  ),
  emailInputPrefix: const Icon(Icons.email),
  passwordInputPrefix: const Icon(Icons.password),
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
