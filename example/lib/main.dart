// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

final loginOptions = LoginOptions(
  decoration: const InputDecoration(
    border: OutlineInputBorder(),
  ),
  emailInputPrefix: const Icon(Icons.email),
  passwordInputPrefix: const Icon(Icons.password),
  title: const Text('Login'),
  image: const FlutterLogo(),
  requestForgotPasswordButtonBuilder: (
    context,
    onPressed,
    isDisabled,
    onDisabledPress,
    translations,
  ) {
    return Opacity(
      opacity: isDisabled ? 0.5 : 1.0,
      child: ElevatedButton(
        onPressed: isDisabled ? onDisabledPress : onPressed,
        child: const Text('Send request'),
      ),
    );
  },
);

void main() {
  runApp(const LoginExample());
}

class LoginExample extends StatelessWidget {
  const LoginExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const LoginScreen(),
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
        title: const Text('Forgot password'),
        description: const Text('Hello world'),
        onRequestForgotPassword: (email) {
          print('Forgot password email sent to $email');
        },
      ),
    );
  }
}
