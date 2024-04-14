import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationService {
  Stream<String?> get userId;

  Future<void> signIn(String email, String password);

  Future<void> signUp(String email, String name, String password);

  Future<void> signOut();
}

class FirebaseAuthenticationService implements AuthenticationService {
  FirebaseAuthenticationService(this.firebaseAuth);

  final FirebaseAuth firebaseAuth;

  @override
  Stream<String?> get userId {
    return firebaseAuth.authStateChanges().map((user) => user?.uid);
  }

  @override
  Future<void> signIn(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signUp(String email, String name, String password) async {
    await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await firebaseAuth.currentUser!.updateDisplayName(name);
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
