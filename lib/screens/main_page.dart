import 'package:cafetopia_flutter/screens/profile/profile_page.dart';
import 'package:cafetopia_flutter/screens/home/home_page.dart';
import 'package:flutter/material.dart';

import 'favorites/favorites_page.dart';

typedef CardSelectedCallback = void Function(int?);

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _navigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 227, 241),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          setState(() {
            _navigationIndex = index;
          });
        },
        selectedIndex: _navigationIndex,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            label: 'Home',
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
          ),
          NavigationDestination(
            label: 'Favorites',
            icon: Icon(Icons.favorite_border_outlined),
            selectedIcon: Icon(Icons.favorite),
          ),
          NavigationDestination(
              label: 'Profile',
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person))
        ],
      ),
      body: <Widget>[
        const HomePage(),
        const FavoritesPage(),
        const ProfilePage(),
      ][_navigationIndex],
    );
  }
}
