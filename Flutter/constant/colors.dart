import 'package:flutter/material.dart';

var white = Colors.white;
var black = Colors.black;
var amber = Colors.amber;
var amber2 = const Color.fromARGB(255, 224, 190, 66);
var green = const Color.fromARGB(255, 35, 75, 64);
var brown = Colors.brown;
var brownlight = Colors.brown[100];

class MyColor {
  background(thm) => thm ? green : white;
  button(thm) => thm ? brownlight : brown;

  text1(thm) => thm ? amber : black;
  text2(thm) => thm ? white : black;
  icon1(thm) => thm ? brownlight : brown;
  icon2(thm) => thm ? amber2 : brown;
}

class MyTextStyle<Widget> {
  appbar(String text, thm) {
    if (thm) {
      return Text(text, style: TextStyle(color: amber));
    } else {
      return Text(text, style: TextStyle(color: black));
    }
  }
}

class DarkMode with ChangeNotifier {
  bool _mode = false;

  bool get mode => _mode;

  void setMode(bool thm) {
    _mode = thm;
    notifyListeners();
  }
}
