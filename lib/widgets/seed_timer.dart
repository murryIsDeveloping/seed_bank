import 'package:MySeedBank/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SeedTimer extends StatelessWidget {
  final DateTime date;

  SeedTimer({
    @required this.date,
  });

  Color _seedColor(double value) {
    if (value < 0.25) {
      return pallette.primary;
    } else if (value < 0.5) {
      return Color(0xFF3AAD9F);
    } else if (value < 0.75) {
      return Color(0xFFF4A261);
    } else {
      return Color(0xFFE76F51);
    }
  }

  double _calculateValue() {
    var daysToExpiry = 365 * 5;
    var daysDif = DateTime.now().difference(date).inDays;
    return (daysDif / daysToExpiry);
  }

  @override
  Widget build(BuildContext context) {
    var _value = _calculateValue();
    return Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 12,
            width: 100,
            child: LinearProgressIndicator(
              backgroundColor: _seedColor(_value),
              value: _value,
              valueColor: AlwaysStoppedAnimation(pallette.shadeAccent),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "Expiry: ${DateFormat("dd MMM yyyy").format(
            date.add(
              Duration(days: 5 * 365),
            ),
          )}",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13,
            fontStyle: FontStyle.italic,
          ),
        )
      ],
    );
  }
}
