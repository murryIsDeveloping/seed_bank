import 'dart:async';

import 'package:MySeedBank/main_drawer.dart';
import 'package:MySeedBank/models/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = "/settings";

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Climate _climate = Climate.Tropical;
  Hemisphere _hemisphere = Hemisphere.Southern;
  Storage _storage = Storage.Box;

  @override
  initState() {
    super.initState();
    getLocation();
  }

  Widget _headingBuilder(String title) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.grey,
        width: 1,
      ))),
      margin: const EdgeInsets.only(top: 20.0, left: 30, right: 30),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget Function(T) _tileFunctionBuilder<T>(
      T controller, Function(T) onChanged) {
    return (T type) {
      return ListTile(
        title: Text(UserPreferences.enumToString(type)),
        leading: Radio(
          groupValue: controller,
          value: type,
          onChanged: (T val) {
            setState(() {
              onChanged(val);
            });
          },
        ),
      );
    };
  }

  getLocation() async {
    var geolocator = Geolocator();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.low, distanceFilter: 10);

    var position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
        locationPermissionLevel: GeolocationPermission.location);

    if (position == null) {
      return;
    }

    setState(() {
      _hemisphere =
          position.latitude > 0 ? Hemisphere.Northern : Hemisphere.Southern;

      print(_hemisphere);
    });
  }

  @override
  Widget build(BuildContext context) {
    var _hemisphereBuilder =
        _tileFunctionBuilder<Hemisphere>(_hemisphere, (val) {
      _hemisphere = val;
    });

    var _climateBuilder = _tileFunctionBuilder<Climate>(_climate, (val) {
      _climate = val;
    });

    var _storageBuilder = _tileFunctionBuilder<Storage>(_storage, (val) {
      _storage = val;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _headingBuilder("Your Hemisphere"),
          _hemisphereBuilder(Hemisphere.Northern),
          _hemisphereBuilder(Hemisphere.Southern),
          _headingBuilder("Your Climate"),
          _climateBuilder(Climate.Tropical),
          _climateBuilder(Climate.Subtropical),
          _climateBuilder(Climate.Arid),
          _climateBuilder(Climate.Temperate),
          _climateBuilder(Climate.Cool),
          _headingBuilder("Storage"),
          _storageBuilder(Storage.Box),
          _storageBuilder(Storage.AirTightContainer),
          _storageBuilder(Storage.Fridge),
        ],
      )),
    );
  }
}
