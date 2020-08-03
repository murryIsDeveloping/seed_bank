import 'package:MySeedBank/models/seed.dart';
import 'package:MySeedBank/styles/colors.dart';
import 'package:MySeedBank/widgets/sort_toggle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../main_drawer.dart';

import './../providers/seeds_provider.dart';

import './../screens/add_seeds_screen.dart';

import './../widgets/no_seeds.dart';
import './../widgets/seed_item.dart';

enum Order { BatchId, Title, Expiry }

enum Filter {
  All,
  Season,
}

class SeedListScreen extends StatefulWidget {
  static const routeName = '/seeds';

  @override
  _SeedListScreenState createState() => _SeedListScreenState();
}

class _SeedListScreenState extends State<SeedListScreen> {
  var direction = Direction.DOWN;
  var active = Order.BatchId;
  var filter = Filter.All;

  var filters = {
    Filter.All: (seed) => true,
    Filter.Season: (seed) => seed.datePacked.month == DateTime.now().month,
  };

  var sorting = (Direction direction) => {
        Order.BatchId: (Seed a, Seed b) =>
            direction == Direction.UP ? b.id - a.id : a.id - b.id,
        Order.Title: (Seed a, Seed b) => direction == Direction.UP
            ? b.title.compareTo(a.title)
            : a.title.compareTo(b.title),
        Order.Expiry: (Seed a, Seed b) {
          var aVal = a.datePacked.difference(DateTime.now()).inDays;
          var bVal = b.datePacked.difference(DateTime.now()).inDays;
          return direction == Direction.UP ? bVal - aVal : aVal - bVal;
        }
      };

  void toggle(Order order) {
    if (order == active) {
      setState(() {
        direction = direction == Direction.DOWN ? Direction.UP : Direction.DOWN;
      });
    } else {
      setState(() {
        active = order;
        direction = Direction.DOWN;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Seeds",
          style: Theme.of(context).textTheme.headline1,
        ),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                filter = value;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem<Filter>(
                value: Filter.All,
                child: Text(
                  'All',
                  style: TextStyle(
                      fontWeight: filter == Filter.All
                          ? FontWeight.bold
                          : FontWeight.normal),
                ),
              ),
              PopupMenuItem<Filter>(
                value: Filter.Season,
                child: Text(
                  'Season',
                  style: TextStyle(
                      fontWeight: filter == Filter.Season
                          ? FontWeight.bold
                          : FontWeight.normal),
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AddSeedsScreen.routeName);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: FutureBuilder(
          future:
              Provider.of<SeedsProvider>(context, listen: false).loadSeeds(),
          builder: (context, snapshot) {
            var sort = sorting(direction)[active];
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: <Widget>[
                      Container(
                        color: pallette.shadeAccent,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SortToggle(
                                  onTap: () {
                                    toggle(Order.BatchId);
                                  },
                                  active: active == Order.BatchId,
                                  title: 'Id',
                                  direction: active == Order.BatchId
                                      ? direction
                                      : Direction.DOWN,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                SortToggle(
                                  onTap: () {
                                    toggle(Order.Title);
                                  },
                                  active: active == Order.Title,
                                  title: 'Seed',
                                  direction: active == Order.Title
                                      ? direction
                                      : Direction.DOWN,
                                ),
                              ],
                            ),
                            SortToggle(
                              onTap: () {
                                toggle(Order.Expiry);
                              },
                              active: active == Order.Expiry,
                              title: 'Expiry',
                              direction: active == Order.Expiry
                                  ? direction
                                  : Direction.DOWN,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Consumer<SeedsProvider>(
                            builder: (context, value, child) {
                          var seeds =
                              value.seeds.where(filters[filter]).toList();
                          var seedCount = seeds.length;

                          seeds.sort(sort);

                          return seedCount > 0
                              ? ListView.builder(
                                  itemCount: seedCount,
                                  itemBuilder: (context, index) {
                                    var seed = seeds[index];

                                    return SeedItem(seed);
                                  },
                                )
                              : NoSeeds();
                        }),
                      )
                    ],
                  );
          }),
    );
  }
}
