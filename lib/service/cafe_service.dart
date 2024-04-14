
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/cafe.dart';

abstract class CafeService {
  Stream<List<Cafe>> get cafes;
}

class FirestoreCafeService implements CafeService {
  FirestoreCafeService(this.firestore);

  final FirebaseFirestore firestore;

  @override
  Stream<List<Cafe>> get cafes {
    return firestore.collection('cafes').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Cafe.fromSnapshot(doc)).toList();
    });
  }
}