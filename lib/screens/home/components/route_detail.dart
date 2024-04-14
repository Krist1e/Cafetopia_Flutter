import 'package:cafetopia_flutter/screens/home/components/cafe_detail_tile.dart';
import 'package:flutter/material.dart';

import '../../../models/cafe.dart';
import '../main_page.dart';

class RouteDetailView extends StatelessWidget {
  const RouteDetailView({super.key,
    required this.cafe,
    required this.selectCard,
  });

  final Cafe cafe;
  final CardSelectedCallback selectCard;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (canPop) {
        Navigator.push(context, const MainPage() as Route<Object?>);
        selectCard(null);
      },
      child: Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.topLeft,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                selectCard(null);
              },
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
          Expanded(child: CafeDetailTile(cafe: cafe)),
        ],
      ),
      ),
    );
  }
}