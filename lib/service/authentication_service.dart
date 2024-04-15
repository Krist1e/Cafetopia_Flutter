

abstract class AuthenticationService {
  Stream<String?> get userIdStream;

  String? get userId;

  Future<void> signIn(String email, String password);

  Future<void> signUp(String email, String name, String password);

  Future<void> signOut();
}
