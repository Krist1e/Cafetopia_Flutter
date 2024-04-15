import 'package:cafetopia_flutter/utils/stream_extensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user.dart';
import '../user_service.dart';

class FirestoreUserService implements UserService {
  final FirebaseFirestore firestore;

  FirestoreUserService(this.firestore);

  @override
  Stream<User> user(String userId) => StreamExtensions.combine(
              [_userSnapshots(userId), _favoriteCafesCount(userId)])
          .map((snapshots) {
        final userSnapshot =
            snapshots[0] as DocumentSnapshot<Map<String, dynamic>>;
        final favoriteCafesCount = snapshots[1] as int;
        final user = User.fromMap(
            userSnapshot.data()!, userSnapshot.id, favoriteCafesCount);
        return user;
      });

  Stream<DocumentSnapshot<Map<String, dynamic>>> _userSnapshots(String userId) {
    return firestore.collection('users').doc(userId).snapshots();
  }

  @override
  Future<void> createUserProfile(
          {required String id,
          required String name,
          required String email}) async =>
      await firestore.collection('users').doc(id).set({
        'name': name,
        'email': email,
        'dateOfRegistration': Timestamp.fromDate(DateTime.now()),
      });

  @override
  Future<void> updateProfile(
          {required String id,
          required String name,
          required String gender,
          required String country,
          required String city,
          required String bio,
          required String favoriteFood}) async =>
      await firestore.collection('users').doc(id).update({
        'name': name,
        'gender': gender,
        'country': country,
        'city': city,
        'bio': bio,
        'favoriteFood': favoriteFood,
      });

  Stream<int> _favoriteCafesCount(String userId) => firestore
      .collection('users')
      .doc(userId)
      .collection('favorites')
      .snapshots()
      .map((snapshot) => snapshot.docs.length);
}
