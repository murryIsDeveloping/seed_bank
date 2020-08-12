import 'package:MySeedBank/models/plant_data.dart';
import 'package:MySeedBank/services/static-database.dart';
import 'package:flutter/foundation.dart';

class PlantRef {
  final String name;
  final int id;

  PlantRef({this.name, this.id});
}

class PlantDataProvider with ChangeNotifier {
  Future<PlantData> loadPlantData(int id) async {
    var plant = await StaticDB.getRecordById('plants', id);
    var companions = await getPlantJoin(id, 'Compainion');
    var avoid = await getPlantJoin(id, 'Avoid');

    var family = await StaticDB.getRecordById('family', plant["familyId"]);
    var familyMembers = await getPlantJoin(plant["familyId"], 'Family');

    return PlantData.fromRows(plant, companions, avoid, family, familyMembers);
  }

  Future<List<Map<String, dynamic>>> filterPlants(String query) async {
    var db = await StaticDB.connect();
    return db.query('plants',
        columns: ['id', 'name'], where: "name LIKE $query", limit: 20);
  }

  Future<List<PlantRef>> plantsList() async {
    var db = await StaticDB.connect();
    var vals = await db.query('plants', columns: ['id', 'name']);
    return vals
        .map((val) => PlantRef(id: val["id"], name: val["name"]))
        .toList();
  }

  Future<Map<String, int>> plantsMap() async {
    var db = await StaticDB.connect();
    var vals = await db.query('plants', columns: ['id', 'name']);
    var m = Map<String, int>();
    vals.forEach((val) => m[val["name"] as String] = val["id"] as int);
    return m;
  }

  Future<List<Map<String, dynamic>>> getPlantJoin(int id, String type) async {
    var db = await StaticDB.connect();
    return db.query('plantsJoin', where: "type = 'Compainion' AND id = $id");
  }
}
