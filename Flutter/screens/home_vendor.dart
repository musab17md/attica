import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:ecom/constant/colors.dart';
import 'package:ecom/widgets/graph_view.dart';
import 'package:ecom/widgets/profile_card2.dart';
import 'package:provider/provider.dart';

import '../constant/navbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/shortcut_icons.dart';

class VendorHome extends StatefulWidget {
  const VendorHome({super.key});

  @override
  State<VendorHome> createState() => _VendorHomeState();
}

class _VendorHomeState extends State<VendorHome> {
  Future<List?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("userkey");
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // @override
  // void initState() {
  //   bool thm = context.watch<DarkMode>().mode;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().background(context.watch<DarkMode>().mode),
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        // backgroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
            // debugPrint(context.watch<DarkTheme>().darkMode.toString());
            // debugPrint(Provider.of<DarkTheme>(context, listen: false)
            //     .darkMode
            //     .toString());
          },
          icon: Icon(
            Icons.menu,
            color: Colors.grey[300],
            // color: Colors.grey[700],
            // color: Theme.of(context).primaryColorDark,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Scaffold(
                          body: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("You have 1 notification"),
                                Text(
                                  "Clear All",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView(
                              children: const [
                                ListTile(
                                  leading: Icon(Icons.info),
                                  title: Text("View your notifications here"),
                                  trailing: Icon(Icons.close),
                                ),
                                ListTile(
                                  leading: Icon(Icons.format_list_bulleted),
                                  title: Text("Your product #33 is Accepted."),
                                  trailing: Icon(Icons.close),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ));
                    });
              },
              child: const Icon(Icons.notifications),
            ),
          )
        ],
        title: Text(
          "916 Digital Gold",
          // style: TextStyle(color: Colors.grey[800]),
          style: TextStyle(color: Colors.grey[300]),
          // style: TextStyle(color: Theme.of(context).primaryColorDark),
        ),
      ),
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   title: Text(
      //     "916 Digital Gold",
      //     style: TextStyle(color: Theme.of(context).primaryColorDark),
      //   ),
      // ),
      drawer: const NavDraw(),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(content: Text("Tab back again to leave")),
        child: FutureBuilder(
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
  // List? userkey;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // BannerView2(),
          const SizedBox(height: 20),
          // ProfileCard(userdetail: widget.userDetail),
          ProfileCard2(userdetail: widget.userDetail),
          const SizedBox(height: 50),
          // ScrollCard(),
          ShortcutIconBar(userdetail: widget.userDetail),
          const SizedBox(height: 50),
          const GraphView(),
        ],
      ),
    );
  }
}
