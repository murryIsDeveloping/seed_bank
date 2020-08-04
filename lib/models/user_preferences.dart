import 'db_item.dart';

enum Climate {
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

enum Storage {
  Box,
  AirTightContainer,
  Fridge,
}

class UserPreferences implements DBItem {
  int id;
  Storage storage;
  Hemisphere hemisphere;
  Climate climate;

  UserPreferences({
    this.id,
    this.storage,
    this.hemisphere,
    this.climate,
  });

  static enumToString<T>(type) {
    final beforeCapitalLetter = RegExp(r"(?=[A-Z])");
    return type.toString().split('.')[1].split(beforeCapitalLetter).join(" ");
  }

  Map<String, dynamic> toMap() {
    return {
      "storage": enumToString(storage),
      "hemisphere": enumToString(hemisphere),
      "climate": enumToString(climate),
    };
  }

  static fromRow(Map<String, dynamic> data) {
    Storage storage;
    Climate climate;
    Hemisphere hemisphere;

    switch (data["storage"]) {
      case "Air Tight Container":
        storage = Storage.AirTightContainer;
        break;
      case "Box":
        storage = Storage.Box;
        break;
      case "Fridge":
        storage = Storage.Fridge;
        break;
    }

    switch (data["climate"]) {
      case "Subtropical":
        climate = Climate.Subtropical;
        break;
      case "Tropical":
        climate = Climate.Tropical;
        break;
      case "Arid":
        climate = Climate.Arid;
        break;
      case "Temperate":
        climate = Climate.Temperate;
        break;
      case "Cool":
        climate = Climate.Cool;
        break;
    }

    switch (data["hemisphere"]) {
      case "Northern":
        hemisphere = Hemisphere.Northern;
        break;
      case "Southern":
        hemisphere = Hemisphere.Southern;
        break;
    }

    return UserPreferences(
      id: data["id"],
      storage: storage,
      hemisphere: hemisphere,
      climate: climate,
    );
  }
}
