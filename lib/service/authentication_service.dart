import 'package:cafetopia_flutter/service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationService {
  Stream<String?> get userIdStream;

  String? get userId;

  Future<void> signIn(String email, String password);

  Future<void> signUp(String email, String name, String password);

  Future<void> signOut();
}

class FirebaseAuthenticationService implements AuthenticationService {
  final FirebaseAuth firebaseAuth;

  final UserService userService;

  FirebaseAuthenticationService(this.firebaseAuth, this.userService);

  @override
  Stream<String?> get userIdStream {
    return firebaseAuth.authStateChanges().map((user) => user?.uid);
  }

  @override
  String? get userId {
    return firebaseAuth.currentUser?.uid;
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
    var userId = firebaseAuth.currentUser!.uid;
    try {
      await userService.createUserProfile(id: userId, name: name, email: email);
    } catch (e) {
      await firebaseAuth.currentUser!.delete();
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
