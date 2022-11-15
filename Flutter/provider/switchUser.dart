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
