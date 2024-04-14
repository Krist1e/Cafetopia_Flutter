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
  User user = const User(name: 'John Doe', email: 'john@gmail.com');

  @override
  Widget build(BuildContext context) => Builder(
        builder: (context) => Scaffold(
          body: ListView(
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
                label: 'Full Name',
                text: user.name,
                onChanged: (name) {},
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Email',
                text: user.email,
                onChanged: (email) {},
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'About',
                text: 'ssss',
                maxLines: 5,
                onChanged: (about) {},
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      );
}
