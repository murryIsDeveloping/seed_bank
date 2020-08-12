import 'package:flutter/foundation.dart';
import './../services/database.dart';
import './../models/seed.dart';

class SeedsProvider with ChangeNotifier {
  List<Seed> _seeds = [];

  List<Seed> get seeds {
    return [..._seeds];
  }

  Future<void> loadSeeds() async {
    var seeds = await DB.getRecords('seeds');
    _seeds = seeds
        .map(
          (data) => Seed(
            title: data["title"],
            quantity: data["quantity"],
            id: data["id"],
            plantId: data["plantId"],
            units: data["units"],
            datePacked: DateTime.parse(data["datePacked"]),
          ),
        )
        .toList();
    notifyListeners();
  }

  Future<void> deleteSeed(int id) async {
    await DB.deleteRecord(id, 'seeds');
    _seeds.removeWhere((seed) => seed.id == id);
    notifyListeners();
  }

  Future<void> addSeed(Seed seed) async {
    seed = await DB.insert('seeds', seed);
    _seeds.add(seed);
    notifyListeners();
  }

  Future<void> updateSeed(Seed seed) async {
    await DB.update(seed.id, 'seeds', seed);
    var seedIndex = _seeds.indexWhere((s) => s.id == seed.id);
    _seeds[seedIndex] = seed;
    notifyListeners();
  }

  Seed seedById(int id) {
    return _seeds.firstWhere(
      (seed) => seed.id == id,
      orElse: () => null,
    );
  }
}
