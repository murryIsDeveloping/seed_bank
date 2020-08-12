import 'package:MySeedBank/main_drawer.dart';
import 'package:MySeedBank/models/user_preferences.dart';
import 'package:MySeedBank/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = "/settings";

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Hemisphere _hemisphere;
  Climate _climate;
  Storage _storage;

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
              Provider.of<UserProvider>(context, listen: false)
                  .setUserPreferences(
                UserPreferences(
                  climate: _climate,
                  hemisphere: _hemisphere,
                  storage: _storage,
                  id: 1,
                ),
              );
            });
          },
        ),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      drawer: MainDrawer(),
      body: FutureBuilder(
        future: Provider.of<UserProvider>(context, listen: false)
            .getUserPreferences(),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var userPreferences =
              Provider.of<UserProvider>(context).userPreferences;

          if (userPreferences == null) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                ),
              ),
            );
          } else {
            var userPreferences =
                Provider.of<UserProvider>(context).userPreferences;

            _hemisphere = userPreferences.hemisphere;
            _climate = userPreferences.climate;
            _storage = userPreferences.storage;

            var _hemisphereBuilder = _tileFunctionBuilder<Hemisphere>(
                userPreferences.hemisphere, (val) {
              _hemisphere = val;
            });

            var _climateBuilder =
                _tileFunctionBuilder<Climate>(userPreferences.climate, (val) {
              _climate = val;
            });

            var _storageBuilder =
                _tileFunctionBuilder<Storage>(userPreferences.storage, (val) {
              _storage = val;
            });

            return SingleChildScrollView(
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
              ),
            );
          }
        },
      ),
    );
  }
}
