import 'package:flutter/material.dart';

class MyProvider with ChangeNotifier {
  int _pageIndex = 0;

  int get page => _pageIndex;

  void pageIndex(int val) {
    _pageIndex = val;
    notifyListeners();
  }
}
