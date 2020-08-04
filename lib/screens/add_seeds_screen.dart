import 'package:MySeedBank/models/seed.dart';
import 'package:MySeedBank/providers/seeds_provider.dart';
import 'package:MySeedBank/screens/seed_detail_screen.dart';
import 'package:MySeedBank/styles/custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import './../main_drawer.dart';

class AddSeedsScreen extends StatefulWidget {
  static const routeName = "/add-seed";

  @override
  _AddSeedsScreenState createState() => _AddSeedsScreenState();
}

class _AddSeedsScreenState extends State<AddSeedsScreen> {
  final _form = GlobalKey<FormState>();
  final _quantityScope = FocusNode();

  var _seed = Seed(
    datePacked: DateTime.now(),
  );
  var _editing = false;
  var _init = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      var _args = ModalRoute.of(context).settings.arguments as Seed;
      if (_args != null) {
        _editing = true;
        _seed = _args;
      }
      _init = false;
    }
  }

  @override
  void dispose() {
    _quantityScope.dispose();

    super.dispose();
  }

  void submitAction(Future Function(Seed) action) {
    if (_form.currentState.validate()) {
      _form.currentState.save();
      _seed.title = _seed.title[0].toUpperCase() + _seed.title.substring(1);
      action(_seed).then((_) {
        Navigator.of(context)
            .popAndPushNamed(SeedDetailScreen.routeName, arguments: _seed.id);
      });
    }
  }

  void addSeed() {
    submitAction((seed) =>
        Provider.of<SeedsProvider>(context, listen: false).addSeed(seed));
  }

  void updateSeed() {
    submitAction((seed) =>
        Provider.of<SeedsProvider>(context, listen: false).updateSeed(seed));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            _editing ? "Edit Seed ${_seed.id}" : "Add Seed",
            style: Theme.of(context).textTheme.headline1,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
            )
          ],
        ),
        drawer: MainDrawer(),
        body: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Seed Name",
                      icon: Icon(CustomIcons.leaf),
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_quantityScope);
                    },
                    onSaved: (newValue) {
                      _seed.title = newValue;
                    },
                    initialValue: _seed.title,
                  ),
                  TextFormField(
                    focusNode: _quantityScope,
                    decoration: InputDecoration(
                      labelText: "Quantity",
                      icon: Icon(Icons.local_post_office),
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onSaved: (newValue) {
                      _seed.quantity = int.parse(newValue);
                    },
                    initialValue:
                        _seed.quantity != null ? _seed.quantity.toString() : "",
                  ),
                  DropdownButtonFormField(
                    onChanged: (val) {},
                    value: _seed.units ?? "Seeds",
                    decoration: InputDecoration(
                      labelText: "Units",
                      icon: Icon(CustomIcons.angellist),
                    ),
                    onSaved: (newValue) {
                      _seed.units = newValue;
                    },
                    items: [
                      DropdownMenuItem(
                        value: 'Seeds',
                        child: Text('Seeds'),
                      ),
                      DropdownMenuItem(
                        value: "Grams",
                        child: Text("Grams"),
                      ),
                      DropdownMenuItem(
                        value: "Kilograms",
                        child: Text("Kilograms"),
                      ),
                      DropdownMenuItem(
                        value: "Packets",
                        child: Text("Packets"),
                      ),
                      DropdownMenuItem(
                        value: "Jars",
                        child: Text("Jars"),
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
                      Column(
                        children: <Widget>[
                          RaisedButton(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Date Packed',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            onPressed: () async {
                              var date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now()
                                    .subtract(Duration(days: 365 * 5)),
                                lastDate: DateTime.now(),
                              );

                              _seed.datePacked =
                                  date == null ? DateTime.now() : date;
                            },
                          ),
                          Text(DateFormat("dd MMM yyyy")
                              .format(_seed.datePacked))
                        ],
                      ),
                      RaisedButton(
                        onPressed: () {
                          _editing ? updateSeed() : addSeed();
                        },
                        child: Text(
                          _editing ? "Update" : "Add",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
