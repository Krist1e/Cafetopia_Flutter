import 'package:cafetopia_flutter/screens/home/main_page.dart';
import 'package:cafetopia_flutter/screens/welcome/welcome_page.dart';
import 'package:cafetopia_flutter/service/authentication_service.dart';
import 'package:cafetopia_flutter/service_locator/service_locator.dart';
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
      home: StreamBuilder(
        stream: locator<AuthenticationService>().userId,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data == null) {
              return const WelcomePage(title: 'Cafetopia');
            } else {
              return const MainPage();
            }
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}