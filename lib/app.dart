import 'package:cafetopia_flutter/screens/welcome/welcome_page.dart';
import 'package:flutter/material.dart';

class CafetopiaApp extends StatelessWidget {
  const CafetopiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
        useMaterial3: true,
      ),
      home: const WelcomePage(title: 'Cafetopia'),
    );
  }
}