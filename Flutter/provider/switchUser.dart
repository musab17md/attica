import 'package:flutter/material.dart';

class SwithUser with ChangeNotifier {
  List userTypes = ['Admin', 'Vendor', 'Photographer'];
  int userId = 0;

  String get currUser => userTypes[userId];

  void switchU(int id) {
    userId = id;
    notifyListeners();
  }
}

class CurrentUser with ChangeNotifier {
  String userId = "";

  String get currUser => userId;

  void setUser(String txt) {
    userId = txt;
    notifyListeners();
  }
}

// class DarkTheme with ChangeNotifier {
//   bool? _darkMode;
//   DarkTheme(this._darkMode);

//   bool? get darkMode => _darkMode;

//   void switchMode(mode) {
//     _darkMode = mode;
//     notifyListeners();
//   }
// }
