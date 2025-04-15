// ignore_for_file: avoid_print

import "package:flutter/material.dart";
import "package:flutter_login/flutter_login.dart";

final loginOptions = LoginOptions(
  emailDecoration: const InputDecoration(
    prefixIcon: Icon(Icons.email),
    border: OutlineInputBorder(),
  ),
  passwordDecoration: const InputDecoration(
    prefixIcon: Icon(Icons.password),
    border: OutlineInputBorder(),
  ),
  image: const FlutterLogo(
    size: 200,
  ),
  biometricsOptions: const LoginBiometricsOptions(
    loginWithBiometrics: true,
    triggerBiometricsAutomatically: false,
  ),
  requestForgotPasswordButtonBuilder: (
    context,
    onPressed,
    isDisabled,
    onDisabledPress,
    translations,
  ) =>
      Opacity(
    opacity: isDisabled ? 0.5 : 1.0,
    child: ElevatedButton(
      onPressed: isDisabled ? onDisabledPress : onPressed,
      child: const Text("Send request"),
    ),
  ),
);

void main() {
  runApp(const LoginExample());
}

class LoginExample extends StatelessWidget {
  const LoginExample({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData.dark(),
        home: const LoginScreen(),
      );
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: EmailPasswordLoginForm(
          title: const Text("Login Demo"),
          options: loginOptions,
          onLogin: (email, password) => print("$email:$password"),
          onRegister: (email, password, ctx) => print("Register!"),
          onForgotPassword: (email, ctx) async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ForgotPasswordScreen(),
              ),
            );
          },
        ),
      );
}

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: ForgotPasswordForm(
          options: loginOptions,
          title: const Text("Forgot password"),
          description: const Text("Hello world"),
          onRequestForgotPassword: (email) {
            print("Forgot password email sent to $email");
          },
        ),
      );
}
