import 'package:flutter/material.dart';
import '../main_page.dart';
import 'cafe_list_tile.dart';
import '../../../view_models/cafe_view_model.dart';

class CafeList extends StatelessWidget {
  const CafeList({super.key,
    required this.viewModel,
    required this.selectCard,
    required this.selected,
  });

  final CafeViewModel viewModel;
  final int? selected;
  final CardSelectedCallback selectCard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8.0),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.cafes.length,
              itemBuilder: (BuildContext context, int index) => CafeListTile(
                cafe: viewModel.cafes[index],
                selectCard: selectCard,
                selected: selected, viewModel: viewModel,
              ),
            ),
          ),
        ],
      ),
    );
  }
}