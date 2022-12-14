import 'dart:convert';
import 'dart:io';

import '../constant/navbar.dart';
import '../constant/urls.dart';
import '../constant/vars.dart';
import '../screens/list_prod_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String selectedFilter = "All";

class ListProductOfVendor extends StatefulWidget {
  const ListProductOfVendor({super.key});

  @override
  State<ListProductOfVendor> createState() => _ListProductOfVendorState();
}

class _ListProductOfVendorState extends State<ListProductOfVendor> {
  List? data;
  List? mydata;

  Future getDataListProducts() async {
    var userk = await getUser();
    final uri = Uri.http(urlMain, '/noti/vendor/${userk[0]}/');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.get(uri, headers: headers);
    debugPrint(response.body);
    data = jsonDecode(response.body);
    debugPrint("ListVendorProd: getData length > ${data!.length}");
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
      backgroundColor: MyColorOld().background(),
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
                      style: ElevatedButton.styleFrom(
                          backgroundColor: MyColorOld().icon2()),
                      child: const Text(
                        "View",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
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
