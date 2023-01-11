import 'package:shared_preferences/shared_preferences.dart';

logout() async {
  print("functions: Logging out");
  final prefs = await SharedPreferences.getInstance();
  prefs.remove("credentials");
}
