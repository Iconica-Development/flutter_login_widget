import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

void main() {
  runApp(const LoginExample());
}

class LoginExample extends StatelessWidget {
  const LoginExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: EmailPasswordLoginForm(
          options: LoginOptions(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            emailInputPrefix: Icon(Icons.email),
            passwordInputPrefix: Icon(Icons.password),
            title: Text('Login'),
            image: FlutterLogo(),
          ),
          // ignore: avoid_print
          onLogin: (email, password) => print('$email:$password'),
          onRegister: (email, password) => print('Register!'),
          onForgotPassword: () {},
        ),
      ),
    );
  }
}
