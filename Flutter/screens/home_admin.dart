import 'package:ecom/widgets/banner_slider.dart';
import 'package:ecom/widgets/graph_view.dart';

import '../constant/navbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHome extends StatelessWidget {
  AdminHome({super.key});

  Future<List?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("userkey");
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: Icon(
            Icons.all_inbox,
            color: Colors.grey[700],
          ),
        ),
        title: Text(
          "916 Digital Gold",
          style: TextStyle(color: Colors.grey[800]),
        ),
      ),
      drawer: const NavDraw(),
      body: FutureBuilder(
        future: getUser(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return AdHome(
              userDetail: snapshot.data,
            );
          }
          return Container();
        },
      ),
    );
  }
}

class AdHome extends StatefulWidget {
  const AdHome({super.key, required this.userDetail});
  final List? userDetail;

  @override
  State<AdHome> createState() => _AdHomeState();
}

class _AdHomeState extends State<AdHome> {
  List? userkey;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          BannerView2(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Home Page (Admin)"),
          ),
          GraphView(),
        ],
      ),
    );
  }
}
