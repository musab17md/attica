import 'package:flutter/material.dart';

class UserDetailProvider with ChangeNotifier {
  String _name = "";
  String _group = "";
  int _app = 0;
  List _detail = [];

  String get name => _name;
  String get group => _group;
  int get app => _app;
  List get detail => _detail;

  void setName(String val) {
    _name = val;
    notifyListeners();
  }

  void setGroup(String val) {
    _group = val;
    notifyListeners();
  }

  void setAppVersion(int val) {
    _app = val;
    notifyListeners();
  }

  void setDetailList(List val) {
    _detail = val;
    notifyListeners();
  }
}
