// import '../constant/navbar.dart';
// import 'package:flutter/material.dart';

// class PhotoHome extends StatelessWidget {
//   const PhotoHome({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: const NavDraw(),
//       appBar: AppBar(
//         title: const Text("916 Digital Gold"),
//       ),
//       body: const PhotographerHome(),
//     );
//   }
// }

// class PhotographerHome extends StatefulWidget {
//   const PhotographerHome({super.key});

//   @override
//   State<PhotographerHome> createState() => _PhotographerHomeState();
// }

// class _PhotographerHomeState extends State<PhotographerHome> {
//   @override
//   Widget build(BuildContext context) {
//     return const Text("Home Page (Photo)");
//   }
// }

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:ecom/widgets/graph_view.dart';

import '../constant/navbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/profile_card2.dart';
import '../widgets/shortcut_icons.dart';

class PhotoHome extends StatelessWidget {
  PhotoHome({super.key});

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
        shadowColor: Colors.transparent,
        // backgroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: Icon(
            Icons.menu,
            color: Colors.grey[300],
            // color: Colors.grey[700],
            // color: Theme.of(context).primaryColorDark,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.notifications),
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
          const Text("Photographer Page"),
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
