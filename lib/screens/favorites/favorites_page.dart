import 'package:cafetopia_flutter/service/cafe_service.dart';
import 'package:cafetopia_flutter/service_locator/service_locator.dart';
import 'package:flutter/material.dart';

import '../home/components/cafe_list.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: locator<CafeService>().favorites,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final cafes = snapshot.data;
          if (cafes == null || cafes.isEmpty) {
            return const Center(child: Text('No favorites found'));
          } else {
            return CafeList(cafes: cafes);
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
