import 'package:MySeedBank/main_drawer.dart';
import 'package:flutter/material.dart';

enum Region {
  Subtropical,
  Tropical,
  Arid,
  Temperate,
  Cool,
}

enum Hemisphere {
  Northern,
  Southern,
}

class SettingsScreen extends StatefulWidget {
  static const routeName = "/settings";

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Region _region = Region.Tropical;
  Hemisphere _hemisphere = Hemisphere.Southern;

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

  Widget _regionTile(Region regionType) {
    String name = regionType.toString().split('.')[1];
    return ListTile(
      title: Text(name),
      leading: Radio(
        groupValue: _region,
        value: regionType,
        onChanged: (Region region) {
          setState(() {
            _region = region;
          });
        },
      ),
    );
  }

  Widget _hemisphereTile(Hemisphere hemisphereType) {
    String name = hemisphereType.toString().split('.')[1];
    return ListTile(
      title: Text(name),
      leading: Radio(
        groupValue: _hemisphere,
        value: hemisphereType,
        onChanged: (Hemisphere hemisphere) {
          setState(() {
            _hemisphere = hemisphere;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          _hemisphereTile(Hemisphere.Northern),
          _hemisphereTile(Hemisphere.Southern),
          _headingBuilder("Your Climate"),
          _regionTile(Region.Tropical),
          _regionTile(Region.Subtropical),
          _regionTile(Region.Arid),
          _regionTile(Region.Temperate),
          _regionTile(Region.Cool),
        ],
      )),
    );
  }
}
