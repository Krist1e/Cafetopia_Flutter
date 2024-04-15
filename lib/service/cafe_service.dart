import 'dart:async';

import '../models/cafe.dart';

abstract class CafeService {
  Stream<List<Cafe>> get cafes;

  Stream<Cafe> cafe(String id);

  Stream<List<Cafe>> get favorites;

  Future<void> toggleFavorite(Cafe cafe);
}
