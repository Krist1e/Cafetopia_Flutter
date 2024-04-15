class Cafe {
  final String id;
  final String name;
  final String address;
  final List<String> tags;
  final List<String> options;
  final String phone;
  final String email;
  final String website;
  final String openHours;
  final String closeHours;
  final String image;
  final List<String> images;
  final String description;

  final bool isFavorite;

  Cafe({
    required this.id,
    required this.name,
    required this.address,
    required this.tags,
    required this.options,
    required this.phone,
    required this.email,
    required this.website,
    required this.openHours,
    required this.closeHours,
    required this.image,
    required this.images,
    required this.description,
    required this.isFavorite,
  });

  factory Cafe.fromMap(Map<String, dynamic> data, String id, bool isFavorite) {
    return Cafe(
      id: id,
      name: data['name'] as String,
      address: data['address'] as String,
      tags: (data['tags'] as List<dynamic>).cast<String>(),
      options: (data['options'] as List<dynamic>).cast<String>(),
      phone: data['phone'] as String,
      email: data['email'] as String,
      website: data['website'] as String,
      openHours: data['openHours'] as String,
      closeHours: data['closeHours'] as String,
      image: data['image'] as String,
      images: (data['images'] as List<dynamic>).cast<String>(),
      description: data['description'] as String,
      isFavorite: isFavorite,
    );
  }
}
