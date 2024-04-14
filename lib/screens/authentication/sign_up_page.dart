import 'package:cafetopia_flutter/screens/authentication/sign_in_page.dart';
import 'package:flutter/material.dart';

import '../../create_route.dart';
import '../welcome/welcome_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (canPop) {
        Navigator.push(
            context,
            createRouteWithTransition(
                const WelcomePage(title: 'Cafetopia'), ltrTransition()));
      },
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
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
                  Column(
                    children: <Widget>[
                      _username(),
                      const SizedBox(height: 20),
                      _email(),
                      const SizedBox(height: 20),
                      _password(),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 30, left: 3),
                    child: _signUpButton(context),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Already have an account?"),
                      _signInButton(context),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

_header() {
  return const Text(
    "Sign up",
    style: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
    ),
  );
}

_description() {
  return Text(
    "Create your account",
    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
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
  );
}

_password() {
  return TextField(
    decoration: InputDecoration(
      hintText: "Password",
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
      fillColor: Colors.brown.withOpacity(0.1),
      filled: true,
      prefixIcon: const Icon(Icons.password),
    ),
    obscureText: true,
    obscuringCharacter: '*',
  );
}

_signUpButton(context) {
  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(vertical: 16),
      backgroundColor: Colors.brown,
    ),
    child: const Text(
      "Sign up",
      style: TextStyle(fontSize: 20, color: Colors.white54),
    ),
  );
}

_signInButton(context) {
  return TextButton(
      onPressed: () {
        Navigator.push(
            context, createRouteWithTransition(const SignInPage(), rtlTransition()));
      },
      child: const Text(
        "Sign In",
        style: TextStyle(color: Colors.brown),
      ));
}
