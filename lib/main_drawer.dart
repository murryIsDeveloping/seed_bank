import 'package:MySeedBank/screens/add_seeds_screen.dart';
import 'package:MySeedBank/screens/seed_list_screen.dart';
import 'package:MySeedBank/styles/custom_icons.dart';
import 'package:MySeedBank/widgets/drawer_item.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            width: double.infinity,
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    CustomIcons.seedbank,
                    color: Colors.white,
                    size: 40,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "My Seed Bank",
                    style: Theme.of(context).textTheme.headline1,
                  )
                ],
              ),
            ),
          ),
          DrawerItem(
            icon: CustomIcons.seedling,
            title: "My Seeds",
            routeName: SeedListScreen.routeName,
          ),
          DrawerItem(
            icon: Icons.add,
            title: "Add Seed",
            routeName: AddSeedsScreen.routeName,
          ),
        ],
      ),
    );
  }
}
