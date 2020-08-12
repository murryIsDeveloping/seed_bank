import './db_item.dart';

class Seed implements DBItem {
  int id;
  int plantId;
  String title;
  int quantity;
  String units;
  DateTime datePacked;

  Seed({
    this.id,
    this.plantId,
    this.title,
    this.quantity,
    this.units,
    this.datePacked,
  });

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "quantity": quantity.toString(),
      "units": units,
      "datePacked": datePacked.toString(),
      "plantId": plantId,
    };
  }

  String idToString() {
    return id.toString().padLeft(3, '0');
  }
}
