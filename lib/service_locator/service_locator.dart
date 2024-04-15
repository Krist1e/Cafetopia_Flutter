import 'package:cafetopia_flutter/service/authentication_service.dart';
import 'package:cafetopia_flutter/service/cafe_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../service/implementations/firebase_authentication_service.dart';
import '../service/implementations/firestore_cafe_service.dart';
import '../service/implementations/firestore_user_service.dart';
import '../service/user_service.dart';

final locator = GetIt.I;

void setupDependencies() {
  locator.registerSingleton(FirebaseAuth.instance);
  locator.registerSingleton(FirebaseFirestore.instance);
  locator.registerSingleton<UserService>(FirestoreUserService(locator()));
  locator.registerSingleton<AuthenticationService>(FirebaseAuthenticationService(locator(), locator()));
  locator.registerSingleton<CafeService>(FirestoreCafeService(locator(), locator()));
}

