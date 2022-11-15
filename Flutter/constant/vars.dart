import 'package:intl/intl.dart';

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
