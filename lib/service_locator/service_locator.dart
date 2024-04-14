import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final locator = GetIt.I;

void setupDependencies() {
  locator.registerSingleton(() => FirebaseAuth.instance);
  locator.registerSingleton(() => FirebaseFirestore.instance);
}

