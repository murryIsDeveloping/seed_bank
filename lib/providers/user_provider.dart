import 'package:MySeedBank/models/user_preferences.dart';
import 'package:MySeedBank/services/database.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  UserPreferences userPreferences;

  Future<void> initUserPreferences() async {
    userPreferences = UserPreferences(
        climate: Climate.Tropical,
        hemisphere: Hemisphere.Southern,
        storage: Storage.Box);
    notifyListeners();
    await DB.insert('user', userPreferences);
  }

  Future<void> setUserPreferences(UserPreferences updatedPreferences) async {
    userPreferences = updatedPreferences;
    notifyListeners();
    await DB.update<UserPreferences>(1, 'user', userPreferences);
  }
}
