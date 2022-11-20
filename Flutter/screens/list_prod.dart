import 'dart:convert';
import 'dart:io';

import 'package:attica/constant/navbar.dart';
import 'package:attica/screens/list_prod_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:attica/constant/urls.dart' as urls;

String selectedFilter = "All";

class ListProduct extends StatefulWidget {
  const ListProduct({super.key});

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  List? data;
  List? mydata;

  Future getDataListProducts() async {
    final uri = urls.listProd;
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.get(uri, headers: headers);
    debugPrint(response.body);
    data = jsonDecode(response.body);
    setState(() {
      mydata = data;
    });
  }

  coloredStatus(st) {
    if (st == "Approved") {
      return const TextStyle(color: Colors.amber);
    }
    if (st == "Pending") {
      return const TextStyle(color: Colors.blue);
    }
    if (st == "Rejected") {
      return const TextStyle(color: Colors.red);
    }
  }

  setMydata(status) {
    selectedFilter = status;
    mydata = data!.where((i) => i["status"] == status).toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getDataListProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDraw(),
      appBar: AppBar(
        title: const Text("List Products"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: (MediaQuery.of(context).size.height) - 150,
            child: ListView.builder(
              itemCount: mydata == null ? 0 : mydata?.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(mydata![index]["product_name"]),
                    subtitle: Row(
                      children: [
                        Text(
                          mydata![index]["status"],
                          style: coloredStatus(mydata![index]["status"]),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(mydata![index]["ornament"]),
                      ],
                    ),
                    trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ViewProduct(myData: mydata![index])));
                        },
                        child: const Text("View")),
                    // children: [
                    //   ListTile(
                    //     title: Text(mydata![index]["qty"].toString()),
                    //     subtitle: Text(mydata![index]["totala"]),
                    //     trailing: ElevatedButton(
                    //         onPressed: () {
                    //           Navigator.push(
                    //               context,
                    //               MaterialPageRoute(
                    //                   builder: ((context) => ViewProduct(
                    //                         myData: mydata![index],
                    //                       ))));
                    //         },
                    //         child: const Text("View")),
                    //   ),
                    // ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
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
      ),
    );
  }
}
