class PlantJoinData {
  int id;
  int plantId;
  String name;

  PlantJoinData({
    this.id,
    this.plantId,
    this.name,
  }) {}

  static List<PlantJoinData> fromRows(List<Map<String, dynamic>> companions) {
    return companions
        .map((companion) => PlantJoinData(
              id: companion["id"],
              plantId: companion["plantId"],
              name: companion["name"],
            ))
        .toList();
  }
}
