import 'package:cafetopia_flutter/screens/authentication/sign_up_page.dart';
import 'package:flutter/material.dart';

import '../../create_route.dart';
import '../home/main_page.dart';
import '../welcome/welcome_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

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
                children: [
                  const SizedBox(height: 150.0),
                  _header(context),
                  const SizedBox(height: 20),
                  _inputField(context),
                  const SizedBox(height: 20),
                  _forgotPassword(context),
                  const SizedBox(height: 20),
                  _signup(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Sign In",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credential to login"),
      ],
    );
  }

  _inputField(context) {
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
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {Navigator.push(
              context, createRoute(const MainPage()));},
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

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Forgot password?",
        style: TextStyle(color: Colors.brown),
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        TextButton(
            onPressed: () {
              Navigator.push(
                  context, createRouteWithTransition(const SignUpPage(), rtlTransition()));
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Colors.brown),
            ))
      ],
    );
  }
}
