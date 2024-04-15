import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../service/user_service.dart';
import '../../service_locator/service_locator.dart';
import 'components/profile.dart';
import 'components/text_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.user});

  final User user;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String name = '';
  String gender = '';
  String country = '';
  String city = '';
  String bio = '';
  String favoriteFood = '';

  @override
  void initState() {
    super.initState();

    name = widget.user.name;
    gender = widget.user.gender;
    country = widget.user.country;
    city = widget.user.city;
    bio = widget.user.bio;
    favoriteFood = widget.user.favoriteFood;
  }

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
                label: 'Name',
                text: name,
                onChanged: (name) {
                  setState(() {
                    this.name = name;
                  });
                },
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Gender',
                text: gender,
                onChanged: (gender) {
                  setState(() {
                    this.gender = gender;
                  });
                },
              ),
              const SizedBox(height: 24),
              // country
              TextFieldWidget(
                label: 'Country',
                text: country,
                onChanged: (country) {
                  setState(() {
                    this.country = country;
                  });
                },
              ),
              const SizedBox(height: 24),
              // city
              TextFieldWidget(
                label: 'City',
                text: city,
                onChanged: (city) {
                  setState(() {
                    this.city = city;
                  });
                },
              ),
              const SizedBox(height: 24),
              // favorite food
              TextFieldWidget(
                label: 'Favorite Food',
                text: favoriteFood,
                onChanged: (food) {
                  setState(() {
                    favoriteFood = food;
                  });
                },
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'About',
                text: bio,
                maxLines: 5,
                onChanged: (about) {
                  setState(() {
                    bio = about;
                  });
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              locator<UserService>()
                  .updateProfile(
                      id: widget.user.id,
                      name: name,
                      gender: gender,
                      country: country,
                      city: city,
                      bio: bio,
                      favoriteFood: favoriteFood)
                  .then((value) => Navigator.of(context).pop());
            },
            backgroundColor: Colors.brown,
            child: const Icon(Icons.save, color: Colors.white),
          ),
          // add button for saving changes
        ),
      );
}
