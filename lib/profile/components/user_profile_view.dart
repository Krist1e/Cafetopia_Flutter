import 'package:cafetopia_flutter/service_locator/service_locator.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../service/authentication_service.dart';
import 'profile.dart';
import '../edit_profile_page.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
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
                  MaterialPageRoute(
                      builder: (context) => EditProfilePage(user: user)),
                );
              },
            ),
            const SizedBox(height: 24),
            buildName(user),
            const SizedBox(height: 24),
            buildPersonalInfo(user),
            const SizedBox(height: 10),
            buildAbout(user),
            // sign out button
            ElevatedButton(
              onPressed: () {
                locator<AuthenticationService>().signOut();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('Sign out'),
            ),
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
        child: Column(
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
