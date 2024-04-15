import 'package:flutter/material.dart';

import '../../service/authentication_service.dart';
import '../../service_locator/service_locator.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: InputDecoration(
              hintText: "Username",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.brown.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.person)),
          controller: _usernameController,
        ),
        const SizedBox(height: 20),
        TextField(
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
          controller: _passwordController,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            locator<AuthenticationService>()
                .signIn(
              _usernameController.text,
              _passwordController.text,
            )
                .then((value) {
              Navigator.of(context).pop();
            });
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.brown.shade400,
          ),
          child: const Text(
            "Sign In",
            style: TextStyle(fontSize: 20, color: Colors.white54),
          ),
        ),
      ],
    );
  }
}
