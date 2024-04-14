import 'package:cafetopia_flutter/service/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.I;

void setupDependencies() {
  locator.registerSingleton(FirebaseAuth.instance);
  locator.registerSingleton(FirebaseFirestore.instance);
  locator.registerSingleton<AuthenticationService>(FirebaseAuthenticationService(locator()));
}

