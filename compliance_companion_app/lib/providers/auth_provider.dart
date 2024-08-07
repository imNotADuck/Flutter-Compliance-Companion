import 'package:flutter/foundation.dart';

class AuthState with ChangeNotifier {
  bool _isSignedIn = false;

  bool get isSignedIn => _isSignedIn;

  void setSignedIn(bool signedIn) {
    _isSignedIn = signedIn;
    notifyListeners();
  }
}
