import 'package:flutter/material.dart';

import '../models/user.dart';
import 'components/profile.dart';
import 'components/text_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  User user = const User(
      name: 'John Doe',
      email: 'john@gmail.com');

  @override
  Widget build(BuildContext context) => Builder(
        builder: (context) => Scaffold(
          body:
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            physics: const BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                imagePath: '',
                isEdit: true,
                onClicked: () async {},
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Name',
                text: user.name,
                onChanged: (name) {},
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Gender',
              text: user.gender,
              onChanged: (gender) {},
              ),
              const SizedBox(height: 24),
              // country
              TextFieldWidget(
                label: 'Country',
                text: user.country,
                onChanged: (country) {},
              ),
              const SizedBox(height: 24),
              // city
              TextFieldWidget(
                label: 'City',
                text: user.city,
                onChanged: (city) {},
              ),
              const SizedBox(height: 24),
              // birthday with date format text
              TextFieldWidget(
                label: 'About',
                text: user.bio,
                maxLines: 5,
                onChanged: (about) {},
              ),
              const SizedBox(height: 10),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            backgroundColor: Colors.brown,
            child: const Icon(Icons.save, color: Colors.white),
          ),
          // add button for saving changes

        ),
      );
}


