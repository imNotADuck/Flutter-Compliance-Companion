import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
    static Future<void> storeUserId(String userId) async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save authenticated userId
    await prefs.setString('userId', userId);
  }
}