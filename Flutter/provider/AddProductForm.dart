import "package:flutter/material.dart";

class UpdateNetAmount with ChangeNotifier {
  int _netW = 0;
  int a = 0;
  int b = 0;

  int get netW => _netW;

  void setGrossW(value){
    a = value;
  }
  void setStoneW(value){
    b = value;
  }

  void calculateNetWeight() {

    debugPrint(a.toString());
    debugPrint(b.toString());
    _netW = a + b;
    debugPrint("_netW.toString()");
    debugPrint(_netW.toString());
    notifyListeners();
  }
}