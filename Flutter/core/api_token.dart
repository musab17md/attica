import 'package:shared_preferences/shared_preferences.dart';

class Token {
  getToken() async {
    String? token;
    await SharedPreferences.getInstance().then((value) {
      token = value.getString('token');
    });
    return token;
  }
}
