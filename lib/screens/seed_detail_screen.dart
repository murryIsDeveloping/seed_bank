import 'package:MySeedBank/providers/seeds_provider.dart';
import 'package:MySeedBank/screens/add_seeds_screen.dart';
import 'package:MySeedBank/screens/seed_list_screen.dart';
import 'package:MySeedBank/styles/custom_icons.dart';
import 'package:MySeedBank/widgets/seed_timer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SeedDetailScreen extends StatelessWidget {
  static const routeName = "/seed-detail";

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as int;
    final dateFormatter = DateFormat("dd MMM yyyy");
    final seed =
        Provider.of<SeedsProvider>(context, listen: false).seedById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(seed != null ? seed.title : ""),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context)
                  .popAndPushNamed(AddSeedsScreen.routeName, arguments: seed);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  "Are You Sure?",
                  textAlign: TextAlign.center,
                ),
                content: Text(
                  "Delete ${seed.title} (\"${seed.idToString()}\")",
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  RaisedButton(
                    child: Text("Yes Delete"),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                  RaisedButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ],
              ),
            ).then(
              (action) {
                if (action) {
                  Provider.of<SeedsProvider>(context, listen: false)
                      .deleteSeed(seed.id)
                      .then((_) {
                    Navigator.of(context)
                        .popAndPushNamed(SeedListScreen.routeName);
                  });
                }
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: seed != null
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              CustomIcons.leaf,
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "\" ${seed.idToString()} \"",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "x ${seed.quantity} ${seed.units}",
                          style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Collected: ${dateFormatter.format(seed.datePacked)}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SeedTimer(date: seed.datePacked),
                      ],
                    ),
                  ],
                ),
              )
            : Container(),
      ),
    );
  }
}
