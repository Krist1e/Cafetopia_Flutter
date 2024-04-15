import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String bio;
  final String country;
  final String city;
  final String dateOfBirth;
  final String dateOfRegistration;
  final int favoriteCafesCount;
  final String favoriteFood;
  final String gender;

  const User(
      {required this.id,
      required this.name,
      required this.email,
      required this.bio,
      required this.country,
      required this.city,
      required this.dateOfBirth,
      required this.dateOfRegistration,
      required this.favoriteCafesCount,
      required this.favoriteFood,
      required this.gender});

  factory User.fromMap(
      Map<String, dynamic> map, String id, int favoriteCafesCount) {
    return User(
        id: id,
        name: map['name'],
        email: map['email'],
        bio: map['bio'],
        country: map['country'],
        city: map['city'],
        dateOfBirth: (map['dateOfBirth'] as Timestamp).toDate().toString(),
        dateOfRegistration: (map['dateOfRegistration'] as Timestamp).toDate().toString(),
        favoriteCafesCount: favoriteCafesCount,
        favoriteFood: map['favoriteFood'],
        gender: map['gender']);
  }
}
