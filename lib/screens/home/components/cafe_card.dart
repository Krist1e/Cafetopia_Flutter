import 'package:flutter/material.dart';

import '../../../models/cafe.dart';

class CafeCard extends StatelessWidget {
  const CafeCard({
    super.key,
    required this.cafe,
    required this.onTap,
    required this.onFavorite,
  });

  final Cafe cafe;
  final Function() onTap;
  final Function() onFavorite;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          _cafeImage(cafe: cafe),
          _cafeInfo(cafe: cafe, context: context),
        ],
      ),
    ));
  }

  _cafeImage({required Cafe cafe}) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.grey,
      ),
    );
  }

  _cafeInfo({required Cafe cafe, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            cafe.name,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Column(
                children: [
                  Text(
                    cafe.address,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cafe.tags.join(', '),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                  onPressed: onFavorite,
                  icon: Icon(
                      cafe.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.redAccent,
                      size: 40))
            ],
          ),
        ],
      ),
    );
  }
}
