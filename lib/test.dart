import 'package:flutter/material.dart';


import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;


class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}



Future<List?> getData(token) async {

  debugPrint("SsAcc: response Start");
  var authEndpoint =
      "http://192.168.0.134:8080/api/datalist/";
  final response = await http.get(
    Uri.parse(authEndpoint),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Token $token"
    },
  );
  debugPrint("SsAcc: ${response.body.toString()}");
  var jsonData = jsonDecode(response.body);

  List<User> users = [];
  for (var u in jsonData) {
    User user = User(u['metal']);
    debugPrint(u['select_metal'].toString());
    debugPrint(user.metal);

    users.add(user);
  }
  debugPrint('SsAcc: ${users.length.toString()}');
  debugPrint('SsAcc: ${response.body}');
  debugPrint('SsAcc: ${response.statusCode.toString()}');
  debugPrint('SsAcc: ${jsonData.toString()}');
  debugPrint("SsAcc: response done");
  debugPrint('SsAcc: ${users[1].metal}');
  return users;
}

class User {
  final dynamic metal;

  User(this.metal);
}





class _MyStatefulWidgetState extends State<MyStatefulWidget> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: FutureBuilder(
            future: getData("68c2a7cc5e09dd2a179438f50d1fd0350096b08b"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              if (snapshot.data == null) {
                return Text(snapshot.error.toString());
              } else {
                return listViewBuilder(snapshot);
              }
            })
      ),

    );
  }
  ListView listViewBuilder(snapshot) {
    return ListView.builder(
      itemCount: snapshot.data?.length,
      reverse: false,
      itemBuilder: ((context, i) {
        return ListTile(
          title: Text(snapshot.data![i].metal.toString()),

        );
      }),
    );
  }

}


