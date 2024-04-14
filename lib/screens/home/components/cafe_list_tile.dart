import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

import 'arguments.dart';
import '../../../models/cafe.dart';
import '../main_page.dart';
import '../../../view_models/cafe_view_model.dart';

class CafeListTile extends StatelessWidget {
  const CafeListTile({super.key,
    required this.cafe,
    required this.selectCard,
    required this.selected,
    required this.viewModel,
  });

  // view model
  final Cafe cafe;
  final int? selected;
  final CardSelectedCallback selectCard;
  final CafeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // The behavior of opening a detail view is different on small screens
        // than large screens.
        // Small screens open a modal with the detail view while large screens
        // simply show the details on the secondaryBody.
        selectCard(viewModel.cafes.indexOf(cafe));
        if (!Breakpoints.mediumAndUp.isActive(context)) {
          Navigator.of(context).pushNamed(ExtractRouteArguments.routeName,
              arguments: ScreenArguments(cafe: cafe, selectCard: selectCard));
        } else {
          selectCard(viewModel.cafes.indexOf(cafe));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: selected == viewModel.cafes.indexOf(cafe)
                ? const Color.fromARGB(255, 234, 222, 255)
                : const Color.fromARGB(255, 243, 237, 247),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  /*leading:
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: (cafe.image != '')
                        ? Image.asset(cafe.image)
                        : Container(),
                  ),*/
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[ Text(
                      cafe.title,
                      style: Theme.of(context).textTheme.titleMedium,
                      softWrap: false,
                      overflow: TextOverflow.clip,
                    ),
                    ],
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: Icon(Icons.star_outline, color: Colors.grey[500]),
                  ),
                ),
                const SizedBox(height: 13),
                Text(cafe.description.length > 20 ? cafe.description.replaceRange(20, cafe.description.length, '...') : cafe.description,
                    style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
        ),
      ),
    );
  }
}