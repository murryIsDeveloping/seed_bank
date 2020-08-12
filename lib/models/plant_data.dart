import 'package:MySeedBank/models/compainion_data.dart';
import 'package:MySeedBank/models/family_data.dart';

class PlantData {
  int id;
  String name;
  String position;
  List<PlantJoinData> compainions;
  List<PlantJoinData> avoid;
  double ph;
  String soil;
  FamilyData family;

  PlantData({
    this.id,
    this.name,
    this.position,
    this.compainions,
    this.avoid,
    this.soil,
    this.ph,
    this.family,
  }) {}

  static PlantData fromRows(
    Map<String, dynamic> plant,
    List<Map<String, dynamic>> companions,
    List<Map<String, dynamic>> avoid,
    Map<String, dynamic> family,
    List<Map<String, dynamic>> familyMembers,
  ) {
    return PlantData(
        id: plant["id"],
        name: plant["name"],
        position: plant["position"],
        soil: plant["soil"],
        compainions: PlantJoinData.fromRows(companions),
        avoid: PlantJoinData.fromRows(avoid),
        ph: plant["ph"],
        family: FamilyData.fromRows(family, familyMembers));
  }
}
