import 'package:flutter/material.dart';
import 'package:cafetopia_flutter/screens/authentication/sign_in_view.dart';
import 'package:cafetopia_flutter/screens/authentication/sign_up_view.dart';

enum AuthMode { signUp, signIn }

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key, required this.mode});

  final AuthMode mode;

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState(mode: mode);
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  AuthMode mode = AuthMode.signUp;

  _AuthenticationPageState({required this.mode});

  void toggleMode() {
    setState(() {
      mode = mode == AuthMode.signUp ? AuthMode.signIn : AuthMode.signUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const SizedBox(height: 150.0),
                  _header(),
                  const SizedBox(height: 10),
                  _description(),
                  const SizedBox(height: 20),
                ],
              ),
              mode == AuthMode.signUp
                  ? const SignUpView()
                  : const SignInView(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(mode == AuthMode.signUp
                      ? "Already have an account?"
                      : "Don't have an account?"),
                  _toggleButton(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _header() {
    return Text(
      mode == AuthMode.signUp ? "Sign Up" : "Sign In",
      style: const TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  _description() {
    return Text(
      mode == AuthMode.signUp
          ? "Create an account to get started"
          : "Enter your credential to login",
      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
    );
  }

  _toggleButton() {
    return TextButton(
        onPressed: toggleMode,
        child: Text(
          mode == AuthMode.signUp ? "Sign In" : "Sign Up",
          style: const TextStyle(color: Colors.brown),
        ));
  }
}
