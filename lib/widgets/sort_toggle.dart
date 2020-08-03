import 'package:flutter/material.dart';

enum Direction { UP, DOWN }

class SortToggle extends StatelessWidget {
  final Function onTap;
  final String title;
  final Direction direction;
  final bool active;

  SortToggle({
    this.title,
    this.direction,
    this.active,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: active ? FontWeight.bold : FontWeight.normal,
                fontSize: 16),
          ),
          Icon(
            direction == Direction.UP
                ? Icons.keyboard_arrow_up
                : Icons.keyboard_arrow_down,
          )
        ],
      ),
    );
  }
}
