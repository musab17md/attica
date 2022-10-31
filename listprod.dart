import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'addprod.dart';
import 'navbar.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({Key? key}) : super(key: key);

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  late Future futureData;

  @override
  void initState() {
    super.initState();
    futureData = getData("68c2a7cc5e09dd2a179438f50d1fd0350096b08b");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDraw(),
      appBar: AppBar(
        title: const Text("Products"),
      ),
      body: Center(
        child: FutureBuilder(
            future: futureData,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              if (snapshot.data == null) {
                return Text(snapshot.error.toString());
              } else {
                debugPrint("Listing data");
                return listViewBuilder(snapshot);
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: ((context) => const AddProduct())));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView listViewBuilder(snapshot) {
    return ListView.builder(
      itemCount: snapshot.data?.length,
      reverse: false,
      itemBuilder: ((context, i) {
        return ListTile(
          title: Text(snapshot.data?[i].metal),
          subtitle: Text(snapshot.data?[i].ornament),
          trailing: Text(snapshot.data[i].purity.toString()),
        );
      }),
    );
  }
}

Future<List?> getData(token) async {
  debugPrint("Getting data");
  var authEndpoint = "http://192.168.0.134:8080/api/datalist/";
  final response = await http.get(
    Uri.parse(authEndpoint),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Token $token"
    },
  );
  var jsonData = jsonDecode(response.body);

  List<User> users = [];
  for (var u in jsonData) {
    User user = User(u['select_metal'], u['ornament_type'], u['purity']);
    users.add(user);
  }
  return users;
}

class User {
  final dynamic metal, ornament, purity;

  User(this.metal, this.ornament, this.purity);
}