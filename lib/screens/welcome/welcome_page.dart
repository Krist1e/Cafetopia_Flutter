import 'package:flutter/material.dart';

import '../../create_route.dart';
import '../authentication/authentication_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    // create welcome page with logo and sign in and sign up buttons
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 50),
      child: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // add margin
              const SizedBox(height: 50),
              _logo(),
              const SizedBox(height: 30),
              _title(title),
              const SizedBox(height: 30),
              _signInButton(context),
              const SizedBox(height: 15),
              _signUpButton(context),
            ],
          ),
        ),
      ),
    );
  }
}

_logo() {
  return Image.asset(
    'lib/assets/logo.png',
    width: 200,
    height: 200,
    color: Colors.brown[700],
  );
}

_title(title) {
  return Text(
    title,
    style: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.brown[700],
      decoration: TextDecoration.none,
    ),
  );
}

_signUpButton(context) {
  return OutlinedButton(
    onPressed: () {
      Navigator.push(
          context,
          createRouteWithTransition(
              const AuthenticationPage(mode: AuthMode.signUp),
              rtlTransition()));
    },
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.brown,
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      side: const BorderSide(color: Colors.brown),
      textStyle: const TextStyle(fontSize: 20),
    ),
    child: const Text('Sign Up'),
  );
}

_signInButton(context) {
  return ElevatedButton(
    onPressed: () {
      // navigate to sign in page and do animation before that
      Navigator.push(
          context,
          createRouteWithTransition(
              const AuthenticationPage(mode: AuthMode.signIn),
              rtlTransition()));
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.brown.shade500,
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      textStyle: const TextStyle(fontSize: 20),
      foregroundColor: Colors.white54,
    ),
    child: const Text('Sign In'),
  );
}
