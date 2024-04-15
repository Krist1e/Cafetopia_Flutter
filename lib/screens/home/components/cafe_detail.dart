import 'package:cached_network_image/cached_network_image.dart';
import 'package:cafetopia_flutter/service_locator/service_locator.dart';
import 'package:flutter/material.dart';

import '../../../models/cafe.dart';
import '../../../service/cafe_service.dart';

class CafeDetail extends StatelessWidget {
  const CafeDetail({super.key, required this.cafe});

  final Cafe cafe;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 150,
              // cached network image to load image from url
              child: CachedNetworkImage(
                imageUrl: cafe.image,
                // round the corners
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(height: 8),
            // title only
            Row(children: [
              Text(cafe.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.brown[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 24)),
              const Spacer(),
              // star icon
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 245, 241, 248),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: IconButton(
                  icon: Icon(
                      cafe.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.redAccent),
                  onPressed: () {
                    locator<CafeService>().toggleFavorite(cafe);
                  },
                ),
              ),
            ]),
            const SizedBox(height: 15),
            // address, tags, and options
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Address: ${cafe.address}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
                // TAGS
                Wrap(
                  children: List.generate(
                    cafe.tags.length,
                    (index) => Container(
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.only(right: 6, bottom: 4),
                      decoration: BoxDecoration(
                        color: Colors.amber[100],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text(
                        cafe.tags[index],
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // OPTIONS
                Wrap(
                  children: List.generate(
                    cafe.options.length,
                    (index) => Container(
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.only(right: 6, bottom: 4),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent[100],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text(
                        cafe.options[index],
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                ),
                // PHONE
                const SizedBox(height: 8),
                Text(
                  'Phone: ${cafe.phone == '' ? 'N/A' : cafe.phone}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                // EMAIL
                const SizedBox(height: 8),
                Text(
                  'Email: ${cafe.email == '' ? 'N/A' : cafe.email}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                // WEBSITE
                const SizedBox(height: 8),
                Text(
                  'Website: ${cafe.website == '' ? 'N/A' : cafe.website}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                // Working hours {openHours - closeHours}
                const SizedBox(height: 8),
                Text(
                  'Working hours: ${cafe.openHours == cafe.closeHours ? '24 hours' : '${cafe.openHours} - ${cafe.closeHours}'}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
              ],
            ),
            Text('Description',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.brown[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            Text(cafe.description,
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 9),
            // Carousel of cafe images
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cafe.images.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                    child: SizedBox(
                      width: 200,
                      child: CachedNetworkImage(
                        imageUrl: cafe.images[index],
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
