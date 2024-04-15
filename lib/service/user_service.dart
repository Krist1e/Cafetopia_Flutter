import '../models/user.dart';

abstract class UserService {
  Stream<User> user(String userId);

  Future<void> createUserProfile(
      {required String id, required String name, required String email});

  Future<void> updateProfile({
    required String id,
    required String name,
    required String gender,
    required String country,
    required String city,
    required String bio,
    required String favoriteFood,
  });
}
