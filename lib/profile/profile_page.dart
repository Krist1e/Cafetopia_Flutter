import 'package:flutter/material.dart';

import '../models/user.dart';
import 'components/profile.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    const user = User(
        name: 'John Doe',
        email: 'john@gmail.com');

    return Builder(
      builder: (context) => Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 32),
          physics: const BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: '',
              onClicked: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const EditProfilePage()),
                );
              },
            ),
            const SizedBox(height: 24),
            buildName(user),
            const SizedBox(height: 24),
            buildPersonalInfo(user),
            const SizedBox(height: 10),
            buildAbout(user),
          ],
        ),
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildPersonalInfo(User user) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gender: ${user.gender}',
            style: const TextStyle(fontSize: 16, height: 1.4),
          ),
          Text(
            'Country: ${user.country}',
            style: const TextStyle(fontSize: 16, height: 1.4),
          ),
          Text(
            'City: ${user.city}',
            style: const TextStyle(fontSize: 16, height: 1.4),
          ),
          Text(
            'Birthday: ${user.dateOfBirth}',
            style: const TextStyle(fontSize: 16, height: 1.4),
          ),
          Text(
            'Registration date: ${user.dateOfRegistration}',
            style: const TextStyle(fontSize: 16, height: 1.4),
          ),
          Text(
            'Favorite cafes: ${user.favoriteCafesCount}',
            style: const TextStyle(fontSize: 16, height: 1.4),
          ),
          Text(
            'Favorite food: ${user.favoriteFood}',
            style: const TextStyle(fontSize: 16, height: 1.4),
          ),
        ],

      ),
  );

  Widget buildAbout(User user) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.bio,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
