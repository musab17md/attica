import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

String date = DateFormat('yMd').format(DateTime.now());
String time = DateFormat('jms').format(DateTime.now());

const List<String> metalType = <String>['Gold', 'Silver'];
const List<String> ornaments = <String>[
  "Anklets",
  "Baby Bangles",
  "Bangles",
  "Bracelet",
  "Broad Bangles",
  "Chain",
  "Chain with Locket",
  "Drops",
  "Ear Rings",
  "Gold Bar",
  "Locket",
  "Matti",
  "Necklace",
  "Ring",
  "Silver Bar",
  "Silver Items",
  "Studs And Drops",
  "Thali Chain",
  "Waist Belt/Chain"
];

const List<String> validDate = <String>[
  '1 Day',
  '3 Day',
  '7 Day',
  '15 Day',
  '30 Day'
];

const List<String> yesNo = <String>[
  'Yes',
  'No',
];

getUser() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('userkey');
}

getType(user) {
  int userid = 0;
  if (user == "Admin") {
    userid = 0;
  }
  if (user == "Vendor") {
    userid = 1;
  }
  if (user == "Photographer") {
    userid = 2;
  }
  return userid;
}

getTheme() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool("theme") ?? false;
}

class MyColorOld {
  var thm = getTheme();
  text1(thm) => thm ? Colors.brown[200] : Colors.brown[800];
  text2() => Colors.black;
  background() => const Color.fromARGB(255, 35, 75, 64);
  card() => const Color.fromARGB(255, 37, 116, 94);
  icon1() => const Color.fromARGB(255, 232, 80, 92);
  icon2() => const Color.fromARGB(255, 224, 190, 66);
}
