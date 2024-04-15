import 'package:cached_network_image/cached_network_image.dart';
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
      child: CachedNetworkImage(
        imageUrl: cafe.image,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => const Center(
            child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      )
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
                    textAlign: TextAlign.left,
                    'Address: ${cafe.address.length > 30
                        ? '${cafe.address.substring(0, 30)}...'
                        : cafe.address}',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    children: // show only 3 tags
                    List.generate(
                      cafe.tags.length > 2 ? 2 : cafe.tags.length,
                          (index) => TagCard(tag: cafe.tags[index]),
                    ),
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

// create card for tags
class TagCard extends StatelessWidget {
  const TagCard({
    super.key,
    required this.tag,
  });

  final String tag;

  @override
  Widget build(BuildContext context) {
    return Card(
      // round the corners
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      // background color
      color: Colors.amber[100],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(// if tag length is more than 10, show only 10 characters
            tag.length > 15 ? '${tag.substring(0, 15)}...' : tag
     , style: Theme.of(context).textTheme.labelSmall),
      ),
    );
  }
}