import 'package:flutter/material.dart';

class StarButton extends StatefulWidget {
  const StarButton({super.key});

  @override
  StarButtonState createState() => StarButtonState();
}

class StarButtonState extends State<StarButton> {
  bool _isStarred = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isStarred ? Icons.star : Icons.star_outline,
        color: _isStarred ? Colors.yellow : Colors.grey[500],
      ),
      onPressed: () {
        setState(() {
          _isStarred = !_isStarred;
        });
      },
    );
  }
}