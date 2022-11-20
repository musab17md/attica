import 'dart:convert';
import 'dart:io';

import 'package:attica/constant/navbar.dart';
import 'package:attica/screens/list_img_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:attica/constant/urls.dart';

String selectedFilter = "All";

class ListPhotoByID extends StatefulWidget {
  const ListPhotoByID({super.key});

  @override
  State<ListPhotoByID> createState() => _ListPhotoByIDState();
}

class _ListPhotoByIDState extends State<ListPhotoByID> {
  List? data;
  List? mydata;

  getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('userkey');
  }

  Future getDataListProducts() async {
    var userk = await getUser();
    debugPrint(userk.toString());
    debugPrint(userk[0].toString());
    final uri = Uri.http(urlMain, '/pics/vendor/${userk[0]}/');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.get(uri, headers: headers);
    debugPrint(response.body);
    data = jsonDecode(response.body);
    setState(() {
      mydata = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getDataListProducts();
  }

  statusColor(stat) {
    if (stat == "Rejected") {
      return TextStyle(color: Colors.red[800]);
    }
    if (stat == "Pending") {
      return const TextStyle(color: Colors.blue);
    } else {
      return const TextStyle(color: Colors.yellow);
    }
  }

  setMydata(status) {
    selectedFilter = status;
    mydata = data!.where((i) => i["status"] == status).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDraw(),
      appBar: AppBar(
        title: const Text("List Photos"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: (MediaQuery.of(context).size.height) - 150,
            child: ListView.builder(
              itemCount: mydata == null ? 0 : mydata?.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ExpansionTile(
                    title: Text(mydata![index]["vendor"]),
                    subtitle: Text(mydata![index]["ornament"]),
                    trailing: Text(
                      mydata![index]["status"],
                      style: statusColor(mydata![index]["status"]),
                    ),
                    children: [
                      ListTile(
                        title: Text(mydata![index]["date"]),
                        subtitle: Text(mydata![index]["time"]),
                        trailing: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => ViewImage(
                                          myData: mydata![index],
                                        ))));
                          },
                          child: const Text("View"),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: filterAction(context),
    );
  }

  FloatingActionButton filterAction(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return SizedBox(
                height: 600,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            selectedFilter = "All";
                            setState(() {
                              mydata = data;
                            });
                            Navigator.pop(context);
                          },
                          child: const Text("All")),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: () {
                            setMydata("Pending");
                            Navigator.pop(context);
                          },
                          child: const Text("Pending")),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: () {
                            setMydata("Approved");
                            Navigator.pop(context);
                          },
                          child: const Text("Approved")),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: () {
                            setMydata("Rejected");
                            Navigator.pop(context);
                          },
                          child: const Text("Rejected")),
                    ],
                  ),
                ),
              );
            });
      },
      child: const Icon(Icons.filter_alt_outlined),
    );
  }
}
