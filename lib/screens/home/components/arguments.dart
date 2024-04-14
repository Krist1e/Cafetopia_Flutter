import 'package:flutter/material.dart';

import '../../../models/cafe.dart';
import 'route_detail.dart';
import '../main_page.dart';

class ScreenArguments {
  ScreenArguments({
    required this.cafe,
    required this.selectCard,
  });

  final Cafe cafe;
  final CardSelectedCallback selectCard;
}

class ExtractRouteArguments extends StatelessWidget {
  const ExtractRouteArguments({super.key});

  static const String routeName = '/detailView';

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args =
    ModalRoute.of(context)!.settings.arguments! as ScreenArguments;

    return RouteDetailView(cafe: args.cafe, selectCard: args.selectCard);
  }
}