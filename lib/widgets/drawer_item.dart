import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String routeName;
  final String title;
  final IconData icon;

  DrawerItem({
    @required this.routeName,
    @required this.title,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (ModalRoute.of(context).settings.name == routeName) {
          Navigator.of(context).pop();
        } else {
          Navigator.of(context).pushReplacementNamed(routeName);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            width: 1,
            color: Theme.of(context).primaryColor,
          ),
        )),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              size: 25,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
