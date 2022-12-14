import 'package:flutter/material.dart';

String atOffice = "You're at Office";
String nearOffice = "You're near Office location";
String farOffice = "You're far from Office location";
String notOffice = "You're not at Office";

class LocationProvider with ChangeNotifier {
  String _curloc = "";

  String get curloc => _curloc;

  void setLocation(text) {
    _curloc = text;
    notifyListeners();
  }
}

class LiveSwitchProvider with ChangeNotifier {
  bool _liveS = true;

  bool get liveS => _liveS;

  void setSwitch(bool val) {
    _liveS = val;
    notifyListeners();
  }
}
