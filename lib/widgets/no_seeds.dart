import 'dart:math';

import 'package:MySeedBank/screens/add_seeds_screen.dart';
import 'package:flutter/material.dart';

import './../styles/custom_icons.dart';

class NoSeeds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(
            CustomIcons.seedbank,
            size: 120,
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: min(MediaQuery.of(context).size.width - 60, 300),
            child: const Text(
              "Looks like you don't have any seeds in your seed bank.",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          RaisedButton(
            elevation: 6,
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 12,
            ),
            onPressed: () {
              Navigator.pushNamed(context, AddSeedsScreen.routeName);
            },
            child: const Text(
              "Add Seeds Now!",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
