import 'dart:convert';
import 'dart:io';

import 'package:attica/constant/navbar.dart';
import 'package:attica/constant/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserControl extends StatefulWidget {
  const UserControl({super.key});

  @override
  State<UserControl> createState() => _UserControlState();
}

class _UserControlState extends State<UserControl> {
  var mydata;
  Future getUsers() async {
    Uri listPics = urlUsers;
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.get(listPics, headers: headers);
    debugPrint(response.body);

    setState(() {
      mydata = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDraw(),
      appBar: AppBar(
        title: const Text("916 Digital Gold"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: (MediaQuery.of(context).size.height) - 150,
            child: ListView.builder(
              itemCount: mydata == null ? 0 : mydata?.length,
              itemBuilder: (BuildContext context, int index) {
                debugPrint(mydata?.length.toString());
                return Card(
                  child: ExpansionTile(
                    title: Text(mydata![index]["username"]),
                    subtitle: Text("Active : ${mydata![index]["is_active"]}"),
                    trailing: Text(
                      "Staff : ${mydata![index]["status"]}",
                    ),
                    children: [
                      ListTile(
                        title: Text(mydata![index]["date_joined"]),
                        subtitle: Text(mydata![index]["groups"].toString()),
                        trailing:
                            Text(mydata![index]["user_permissions"].toString()),
                      ),
                      // SizedBox(
                      //   height: 200,
                      //   child: ListView(
                      //     scrollDirection: Axis.horizontal,
                      //     children: [
                      //       scrollImg("ProdPic1.jpg", context),
                      //       scrollImg("ProdPic2.jpg", context),
                      //       scrollImg("ProdPic3.jpg", context),
                      //       scrollVid("ProdVideo.mp4"),
                      //       scrollImg("ModalPic1.jpg", context),
                      //       scrollImg("ModalPic2.jpg", context),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
