import 'package:MySeedBank/models/compainion_data.dart';

class FamilyData {
  int id;
  String name;
  String lifeSpan;
  List<PlantJoinData> plants;

  FamilyData({
    this.id,
    this.name,
    this.lifeSpan,
    this.plants,
  }) {}

  static FamilyData fromRows(
      Map<String, dynamic> family, List<Map<String, dynamic>> plants) {
    return FamilyData(
      id: family["id"],
      name: family["name"],
      lifeSpan: family["lifeSpan"],
      plants: plants.map((companion) => companion["name"]).toList(),
    );
  }
}
