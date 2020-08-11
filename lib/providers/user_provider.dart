import 'package:MySeedBank/models/user_preferences.dart';
import 'package:MySeedBank/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class UserProvider with ChangeNotifier {
  UserPreferences userPreferences;

  Future<void> _initUserPreferences() async {
    var hemisphere = await _getLocation();
    userPreferences = UserPreferences(
      climate: Climate.Tropical,
      hemisphere: hemisphere,
      storage: Storage.Box,
    );
    notifyListeners();
    await DB.insert('user', userPreferences);
  }

  Future<Hemisphere> _getLocation() async {
    var geolocator = Geolocator();
    var position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
        locationPermissionLevel: GeolocationPermission.location);

    if (position == null) {
      return Hemisphere.Southern;
    }
    return position.latitude >= 0 ? Hemisphere.Northern : Hemisphere.Southern;
  }

  Future<void> getUserPreferences() async {
    var data = await DB.getRecordById<UserPreferences>('user', 1);
    if (data == null) {
      await _initUserPreferences();
    } else {
      userPreferences = UserPreferences.fromRow(data);
      notifyListeners();
    }
  }

  Future<void> setUserPreferences(UserPreferences updatedPreferences) async {
    userPreferences = updatedPreferences;
    notifyListeners();
    await DB.update<UserPreferences>(1, 'user', userPreferences);
  }
}
