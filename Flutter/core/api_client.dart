import 'dart:convert';
import 'dart:io';

import 'package:ecom/constant/urls.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future registerUser() async {
    //IMPLEMENT USER REGISTRATION
  }

  Future login(String user, String pass) async {
    String authEndpoint = "http://192.168.0.134:8123/auth/";
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
    return response;
  }

  Future userType() async {
    //GET USER PROFILE DATA
    Uri url = currentUserUrl;
    String token = await getToken();
    Map data = {
      'usr': token,
    };
    var body = json.encode(data);
    http.Response response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    // print(jsonDecode(response.body));
    return response;
  }

  Future logout() async {
    //IMPLEMENT USER LOGOUT
  }

  getDirFile(name) async {
    final directory = await getApplicationDocumentsDirectory();
    List files = Directory(directory.path).listSync();
    // "ProdPic3"

    for (var i = 0; i < files.length; i++) {
      if (files[i].toString().contains(name)) {
        print(files[i].toString());
        return files[i].toString();
      }
    }
  }

  Future uploadImage(vendor, ornament) async {}

  Future postData(List myData) async {
    String authEndpoint = "http://192.168.0.134:8123/noti/";
    print(myData[0]);
    print(myData[17]);
    print(myData.toString());
    Map<String, String> data = {
      "metal": myData[0],
      "ornament": myData[1],
      "purity": myData[2],
      "rate": myData[3],
      "grossw": myData[4],
      "stonew": myData[5],
      "makingc": myData[6],
      "wastagec": myData[7],
      "stonec": myData[8],
      "netw": myData[9],
      "neta": myData[10],
      "totala": myData[11],
      "vaildd": myData[12],
      "qty": myData[13],
      "vendor": myData[14],
      "submitdate": myData[15],
      "image": myData[16],
      "status": myData[17],
      "product_name": myData[20]
    };
    var request = http.MultipartRequest('POST', Uri.parse(authEndpoint));
    request.fields.addAll(data);
    http.StreamedResponse response = await request.send();
    // var body = json.encode(data);
    // var response = await http.post(
    //   Uri.parse(authEndpoint),
    //   body: body,
    // );
    print(response.statusCode);
    print(response.headers.toString());
    var myResponse = http.Response.fromStream(response);
    print(myResponse);
    return myResponse;
  }

  patchApprove(authEndpoint, body) async {
    String token = await getToken();
    http.Response response = await http.patch(
      Uri.parse(authEndpoint),
      headers: {
        "Content-Type": "application/json",
        // "Authorization": "Token $token"
      },
      body: body,
    );
    return response;
  }

  patchDeny(authEndpoint, body) async {
    String token = await getToken();
    http.Response response = await http.patch(
      Uri.parse(authEndpoint),
      headers: {
        "Content-Type": "application/json",
        // "Authorization": "Token $token"
      },
      body: body,
    );
    return response;
  }

  getData(authEndpoint) async {
    String token = await getToken();
    http.Response response = await http.get(
      Uri.parse(authEndpoint),
      headers: {
        "Content-Type": "application/json",
        // "Authorization": "Token $token"
      },
    );
    return response;
  }
}
