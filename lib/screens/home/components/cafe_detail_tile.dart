import 'package:cafetopia_flutter/screens/home/components/star_button.dart';
import 'package:flutter/material.dart';

import '../../../models/cafe.dart';

class CafeDetailTile extends StatelessWidget {
  const CafeDetailTile({super.key,
    required this.cafe
  });

  final Cafe cafe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  // Cafe cover image
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        image: AssetImage(cafe.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // title only
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          cafe.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 7),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // star icon
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 245, 241, 248),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child:
                    // star button for adding cafe to favorites
                    const StarButton(),
                  ),

                ],
              ),
              const SizedBox(height: 15),
              Text(cafe.description, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 9),
              // Carousel of cafe images
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cafe.images.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            image: AssetImage(cafe.images[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}