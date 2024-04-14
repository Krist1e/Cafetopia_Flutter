import 'package:flutter/material.dart';

import '../models/cafe.dart';

class CafeViewModel extends ChangeNotifier {

  List<Cafe> _cafes = [];
  List<Cafe> get cafes => _allItems;
  final List<Cafe> _allItems = [
    const Cafe(
      title: 'Cafe 1',
      image: 'assets/images/cafe1.jpg',
      description: 'Cafe 1 description',
      images: [
        'assets/images/cafe1.jpg',
        'assets/images/cafe2.jpg',
        'assets/images/cafe3.jpg',
      ],
    ),
    const Cafe(
      title: 'Cafe 2',
      image: 'assets/images/cafe2.jpg',
      description: 'Cafe 2 description',
      images: [
        'assets/images/cafe2.jpg',
        'assets/images/cafe3.jpg',
        'assets/images/cafe1.jpg',
      ],
    ),
    const Cafe(
      title: 'Cafe 3',
      image: 'assets/images/cafe3.jpg',
      description: 'Cafe 3 description',
      images: [
        'assets/images/cafe3.jpg',
        'assets/images/cafe1.jpg',
        'assets/images/cafe2.jpg',
      ],
    ),
  ];

  Future<void> fetchCafes() async {
    _cafes = _allItems;
    notifyListeners();
  }
}