import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState with ChangeNotifier {
  bool _isSignedIn = false;

  bool get isSignedIn => _isSignedIn;

  void setSignedIn(bool signedIn) {
    _isSignedIn = signedIn;
    notifyListeners();
  }

  String? _userId;
  String? get userId => _userId;

  Future<void> loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('userId');
    notifyListeners();
  }

  Future<void> setUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    _userId = userId;
    notifyListeners();
  }
}
