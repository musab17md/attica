import '../constant/navbar.dart';
import '../provider/SwitchUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  String userType = "";
  List userdetail = [];

  getType() async {
    final prefs = await SharedPreferences.getInstance();
    userdetail = prefs.getStringList("userkey")!;
    userType = userdetail[1];
    int userid = 0;
    if (userType == "Admin") {
      userid = 0;
    }
    if (userType == "Vendor") {
      userid = 1;
    }
    if (userType == "Photographer") {
      userid = 2;
    }
    context.read<SwithUser>().switchU(userid);
    return userType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      drawer: const NavDraw(),
      body: FutureBuilder(
          future: getType(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                width: double.infinity,
                height: 500,
                child: Column(
                  children: [
                    Text(userType),
                    Text("Username : ${userdetail[2]}"),
                  ],
                ),
              );
            }
            return Container();
          }),
    );
  }
}
