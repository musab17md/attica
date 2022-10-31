import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  Future registerUser() async {
    //IMPLEMENT USER REGISTRATION
  }

  Future login(String user, String pass) async {
    String authEndpoint = "http://192.168.0.134/auth/";
    Map data = {
      'username': user,
      'password': pass,
    };
    var body = json.encode(data);
    var response = await http.post(
      Uri.parse(authEndpoint),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    return response.body;
  }

  Future getUserProfileData() async {
    //GET USER PROFILE DATA
  }

  Future logout() async {
    //IMPLEMENT USER LOGOUT
  }

  Future postData(List myData) async {
    String authEndpoint = "http://192.168.0.134/connect_database/insert2.php";
    print(myData[0]);
    print(myData[17]);
    var data = {
      "metal": myData[0],
      "ornament": myData[1],
      "purity": myData[2],
      "rate": myData[3],
      "grossW": myData[4],
      "stoneW": myData[5],
      "makingC": myData[6],
      "wastageC": myData[7],
      "stoneC": myData[8],
      "netW": myData[9],
      "NetA": myData[10],
      "totalA": myData[11],
      "vaildD": myData[12],
      "qty": myData[13],
      "vendor": myData[14],
      "submitDate": myData[15],
      "image": myData[16],
      "status": myData[17]
    };
    var body = json.encode(data);
    var response = await http.post(
      Uri.parse(authEndpoint),
      body: data,
    );
    print(response.statusCode);
    print(response.body.toString());
    return response;
  }
}
