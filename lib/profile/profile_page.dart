import 'package:flutter/material.dart';

import '../models/user.dart';
import 'components/button.dart';
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
    const user = User(name: 'John Doe', email: 'john@gmail.com');

    return Builder(
      builder: (context) => Scaffold(
        body: ListView(
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
            Center(child: buildUpgradeButton()),
            const SizedBox(height: 48),
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

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'hehehe',
        onClicked: () {},
      );

  Widget buildAbout(User user) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'ssssss',
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
