import 'package:flutter/material.dart';

import '../../service/authentication_service.dart';
import '../../service_locator/service_locator.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _username(),
        const SizedBox(height: 20),
        _email(),
        const SizedBox(height: 20),
        _password(),
        const SizedBox(height: 20),
        _signUpButton(),
      ],
    );
  }

  _username() {
    return TextField(
      decoration: InputDecoration(
          hintText: "Username",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none),
          fillColor: Colors.brown.withOpacity(0.1),
          filled: true,
          prefixIcon: const Icon(Icons.person)),
      controller: _usernameController,
    );
  }

  _email() {
    return TextField(
      decoration: InputDecoration(
          hintText: "Email",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none),
          fillColor: Colors.brown.withOpacity(0.1),
          filled: true,
          prefixIcon: const Icon(Icons.email)),
      controller: _emailController,
    );
  }

  _password() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Password",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none),
        fillColor: Colors.brown.withOpacity(0.1),
        filled: true,
        prefixIcon: const Icon(Icons.password),
      ),
      obscureText: true,
      obscuringCharacter: '*',
      controller: _passwordController,
    );
  }

  _signUpButton() {
    return ElevatedButton(
      onPressed: () {
        locator<AuthenticationService>().signUp(_emailController.text,
            _usernameController.text, _passwordController.text);
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Colors.brown.shade400,
      ),
      child: const Text(
        "Sign Up",
        style: TextStyle(fontSize: 20, color: Colors.white54),
      ),
    );
  }
}
