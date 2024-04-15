import 'package:cafetopia_flutter/service/authentication_service.dart';
import 'package:cafetopia_flutter/service/user_service.dart';
import 'package:cafetopia_flutter/service_locator/service_locator.dart';
import 'package:flutter/material.dart';

import 'components/user_profile_view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var userId = locator<AuthenticationService>().userId;
    if (userId == null) {
      return const Center(child: Text('No user found'));
    } else {
      return _buildProfile(userId);
    }
  }

  Widget _buildProfile(String userId) {
    return StreamBuilder(
        stream: locator<UserService>().user(userId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data;
            if (user == null) {
              return const Center(child: Text('No user found'));
            } else {
              return UserProfileView(user: user);
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
