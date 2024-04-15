import 'package:cloud_firestore/cloud_firestore.dart';

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

class FirestoreUserService implements UserService {
  final FirebaseFirestore firestore;

  FirestoreUserService(this.firestore);

  @override
  Stream<User> user(String userId) {
    return _userSnapshots(userId).map((snapshot) {
      if (!snapshot.exists) {
        throw StateError('User not found');
      }
      return User.fromMap(snapshot.data()!, snapshot.id, 0);
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> _userSnapshots(String userId) {
    return firestore.collection('users').doc(userId).snapshots();
  }

  @override
  Future<void> createUserProfile(
      {required String id, required String name, required String email}) {
    return firestore.collection('users').doc(id).set({
      'name': name,
      'email': email,
      'dateOfRegistration': DateTime.now().toIso8601String(),
    });
  }

  @override
  Future<void> updateProfile(
      {required String id,
      required String name,
      required String gender,
      required String country,
      required String city,
      required String bio,
      required String favoriteFood}) {
    return firestore.collection('users').doc(id).update({
      'name': name,
      'gender': gender,
      'country': country,
      'city': city,
      'bio': bio,
      'favoriteFood': favoriteFood,
    });
  }
}