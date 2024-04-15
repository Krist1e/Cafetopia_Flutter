import 'package:cafetopia_flutter/service/authentication_service.dart';
import 'package:cafetopia_flutter/service_locator/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupDependencies();
  runApp(
    StreamProvider(
      create: (context) => locator<AuthenticationService>().userIdStream,
      initialData: null,
      child: const CafetopiaApp(),
    ),
  );
}