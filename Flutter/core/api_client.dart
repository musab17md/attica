import 'dart:convert';
import 'dart:io';

import '../constant/urls.dart';
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
    String authEndpoint = urlAuth;
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

  Future login2(String user, String pass) async {
    final prefs = await SharedPreferences.getInstance();
    String authEndpoint = "http://$urlMain/authenticate/";
    print("ApiClient: Login2 start");
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
    var resp = json.decode(response.body);
    print("ApiClient: response.body > $resp");
    if (response.statusCode.toString() != "404") {
      // print(resp["username"]);
      // {"type": "Admin", "username": "msb", "password": "mmmmm", "branch": "mmm", "agent": "mmm", "date": "date", "active": "0"}
      List<String> mydata = [
        resp["id"].toString(),
        resp["type"],
        resp["username"],
        resp["password"],
        resp["branch"],
        resp["agent"],
        resp["date"],
        resp["active"],
      ];
      print("ApiClient: Sharedpref setting up userkey list");
      prefs.setStringList("userkey", mydata);
      // print("ApiClient: set user type in provider UserType");
      // UserType().setUserType(resp["type"]);
    }
    print("ApiClient: Login2 > ${response.statusCode}");
    print("ApiClient: Login2 > ${response.body}");
    return response;
  }

  Future changePass(user, newpass) async {
    String authEndpoint = "http://$urlMain/changepass/";
    Map data = {
      'username': user,
      'password': newpass,
    };
    print("ApiClient: changepass > $data");
    var body = json.encode(data);
    var response = await http.post(
      Uri.parse(authEndpoint),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    final prefs = await SharedPreferences.getInstance();
    var resp = json.decode(response.body);
    if (response.statusCode.toString() != "404") {
      List? key = prefs.getStringList("userkey");
      key![2] = newpass;
      print("ApiClient: $resp");
      return "success";
    }
    print("ApiClient: ${response.statusCode}");
    return "failed";
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

  getDirFile(name) async {
    final directory = await getApplicationDocumentsDirectory();
    List files = Directory(directory.path).listSync();
    // "ProdPic3"

    for (var i = 0; i < files.length; i++) {
      if (files[i].toString().contains(name)) {
        print("ApiClient: getdirfile > ${files[i]}");
        return files[i].toString();
      }
    }
  }

  Future postData(List myData) async {
    String authEndpoint = "http://$urlMain/noti/";
    print("Apiclient: postData first > ${myData[0]}");
    print("Apiclient: postData 17th > ${myData[17]}");
    print("ApiClient: postData myData > $myData");
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
    print("ApiClient: postData statuscode > ${response.statusCode}");
    print("ApiClient: headers > ${response.headers}");
    var myResponse = http.Response.fromStream(response);
    print("ApiClient: postData myResponse > $myResponse");
    return myResponse;
  }

  patchJson(authEndpoint, body) async {
    // String token = await getToken();
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

  getVendorList() async {
    String authEndpoint = "http://$urlMain/vendors/";
    var response = await http.get(
      Uri.parse(authEndpoint),
      headers: {"Content-Type": "application/json"},
    );
    var resp = json.decode(response.body);
    // print("ApiClient: $resp");
    return resp;
  }

  getData(authEndpoint) async {
    // String token = await getToken();
    http.Response response = await http.get(
      Uri.parse(authEndpoint),
      headers: {
        "Content-Type": "application/json",
        // "Authorization": "Token $token"
      },
    );
    return response;
  }

  getWithPostJson(authEndpoint, body) async {
    http.Response response = await http.post(
      Uri.parse(authEndpoint),
      headers: {
        "Content-Type": "application/json",
        // "Authorization": "Token $token"
      },
      body: body,
    );
    return response;
  }

  postJson(Uri url, body) async {
    final headers = {"Content-Type": 'application/json'};
    final response = await http.post(url, headers: headers, body: body);
    print("ApiClient: ${response.statusCode.toString()}");
    return response;
  }
}
