import 'package:cloud_firestore/cloud_firestore.dart';

class Cafe {
  const Cafe({
    required this.title,
    required this.image,
    required this.description,
    required this.images,
  });

  final String title;
  final String image;
  final String description;
  final List<String> images;

  factory Cafe.fromSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Cafe(
      title: data['title'] as String,
      image: data['image'] as String,
      description: data['description'] as String,
      images: (data['images'] as List<dynamic>).cast<String>(),
    );
  }
}