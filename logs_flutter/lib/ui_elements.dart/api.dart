import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String domain = '192.168.1.9:8123';

printResp(response, funcname) {
  print("Api: $funcname > response $response");
  print("Api: $funcname > response ${response.body}");
}

getToken(username, password) async {
  var url = Uri.http(domain, 'api/auth/');
  var response =
      await http.post(url, body: {'username': username, 'password': password});
  printResp(response, 'getToken');
  return response;
}

storedToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

getJson(urlpath) async {
  var token = await storedToken();
  var headers = {
    'Authorization': 'Token $token',
  };
  var url = Uri.http(domain, urlpath);
  final response = await http.get(url, headers: headers);
  printResp(response, 'getJson');
  return response;
}

postJson(urlpath, body) async {
  var token = await storedToken();
  var headers = {
    'Authorization': 'Token $token',
  };
  var url = Uri.http(domain, urlpath);
  var response = await http.post(url, headers: headers, body: jsonEncode(body));
  printResp(response, 'postJson');
  return response;
}

postOtp(number, otp) async {
  var headers = {
    'api-key': 'Aa42377fe5eecb17f0f1fc8c1be4078ca',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  var request = http.Request(
      'POST', Uri.parse('https://api.kaleyra.io/v1/HXIN1737593134IN/messages'));
  request.bodyFields = {
    'to': '91$number',
    'sender': 'atdigi',
    'source': 'API',
    'type': 'TXN',
    'body':
        'Dear Otp $otp, Thank you for choosing Swach Fuels. our deployment team will get in touch with you. For more info visit www.swachhfuels.com or you can call us on 8095-065-065.',
    'template_id': '1407165839198867821'
  };
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
