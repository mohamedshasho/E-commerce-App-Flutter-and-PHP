import 'package:flutter/material.dart';

class CardCategory extends StatelessWidget {
  final Function onPressed;
  final Color color;

  final String title;
  const CardCategory(
      {@required this.onPressed, @required this.title, this.color});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: color,
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title),
        ),
      ),
    );
  }
}
