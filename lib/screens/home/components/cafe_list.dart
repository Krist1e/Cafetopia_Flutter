import 'package:flutter/material.dart';

import '../../../models/cafe.dart';
import '../../../service/cafe_service.dart';
import '../../../service_locator/service_locator.dart';
import 'cafe_card.dart';
import 'cafe_detail.dart';

class CafeList extends StatelessWidget {
  const CafeList({
    super.key,
    required this.cafes,
  });

  final List<Cafe> cafes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(8.0),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: cafes.length,
            itemBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: CafeCard(
                cafe: cafes[index],
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => StreamBuilder(
                          stream: locator<CafeService>().cafe(cafes[index].id),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final cafe = snapshot.data;
                              if (cafe == null) {
                                return const Center(
                                    child: Text('Cafe not found'));
                              } else {
                                return CafeDetail(cafe: cafe);
                              }
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          }),
                    ),
                  );
                },
                onFavorite: () {
                  locator<CafeService>().toggleFavorite(cafes[index]);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
