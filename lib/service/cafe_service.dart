import 'dart:async';

import 'package:cafetopia_flutter/service/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/cafe.dart';
import '../utils/stream_extensions.dart';

abstract class CafeService {
  Stream<List<Cafe>> get cafes;

  Stream<Cafe> cafe(String id);

  Stream<List<Cafe>> get favorites;

  Future<void> toggleFavorite(Cafe cafe);
}

class FirestoreCafeService implements CafeService {
  final AuthenticationService authenticationService;
  final FirebaseFirestore firestore;

  FirestoreCafeService(this.firestore, this.authenticationService);

  @override
  Stream<List<Cafe>> get cafes {
    var userId = authenticationService.userId;
    if (userId == null) {
      return const Stream.empty();
    }
    return StreamExtensions.combine([
      _cafesSnapshots(),
      _favoritesSnapshots(userId),
    ]).map((snapshots) {
      final cafes = snapshots[0].docs.map((doc) {
        final isFavorite =
            snapshots[1].docs.any((favorite) => favorite.id == doc.id);
        return Cafe.fromMap(doc.data(), doc.id, isFavorite);
      }).toList();
      return cafes;
    });
  }

  @override
  Stream<Cafe> cafe(String id) {
    var userId = authenticationService.userId;
    if (userId == null) {
      return const Stream.empty();
    }
    return StreamExtensions.combine([
      _cafeSnapshots(id),
      _favoriteSnapshots(userId, id),
    ]).map((snapshots) {
      if (!snapshots[0].exists) {
        throw StateError('Cafe not found');
      }
      final cafe = Cafe.fromMap(
          snapshots[0].data()!, snapshots[0].id, snapshots[1].exists);
      return cafe;
    });
  }

  @override
  Stream<List<Cafe>> get favorites =>
      cafes.map((cafes) => cafes.where((cafe) => cafe.isFavorite).toList());

  Stream<QuerySnapshot<Map<String, dynamic>>> _cafesSnapshots() {
    return firestore.collection('cafes').snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> _cafeSnapshots(String id) {
    return firestore.collection('cafes').doc(id).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _favoritesSnapshots(
      String userId) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> _favoriteSnapshots(
      String userId, String cafeId) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(cafeId)
        .snapshots();
  }

  @override
  Future<void> toggleFavorite(Cafe cafe) {
    var userId = authenticationService.userId;
    if (userId == null) {
      return Future.error('User is not signed in');
    }
    var userRef = firestore.collection('users').doc(userId);
    var favoriteRef = userRef.collection('favorites').doc(cafe.id);
    return favoriteRef.get().then((doc) {
      if (doc.exists) {
        return favoriteRef.delete();
      } else {
        return favoriteRef.set({});
      }
    });
  }
}
