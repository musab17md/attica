import 'package:ecom/provider/SwitchUser.dart';
import 'package:ecom/register/login.dart';
import 'package:ecom/screens/home_design1.dart';
import 'package:ecom/screens/list_prod.dart';
import 'package:ecom/screens/list_prod_by_id.dart';
import 'package:ecom/screens/upload_image.dart';
import 'package:ecom/tests/addprod4.dart';
import 'package:ecom/screens/list_img.dart';
import 'package:ecom/tests/test.dart';
import 'package:ecom/tests/test3.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

class NavDraw extends StatelessWidget {
  const NavDraw({Key? key}) : super(key: key);
  // late AnimationController _controller = AnimationController(vsync: value, duration: const Duration(seconds: 2))..repeat();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              padding: const EdgeInsets.all(0),
              // decoration:
              //     const BoxDecoration(color: Color.fromARGB(255, 32, 7, 7)),
              child: Stack(
                children: [
                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Image.asset(
                        // "assets/background1.webp",
                        // "assets/background2.jpg",
                        // "assets/background3.jpg",
                        "assets/background4.jpg",
                      ),
                    ),
                  ),

                  // const LogoSpin(duration: Duration(seconds: 2)),
                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: ColoredBox(
                        color:
                            Colors.black.withOpacity(0.5) // 0: Light, 1: Dark
                        ),
                  ),

                  Center(
                    // child: Text(
                    //   "916 Digital Gold",
                    //   style: GoogleFonts.sacramento(
                    //       fontSize: 28,
                    //       // color: Colors.red,
                    //       color: const Color.fromARGB(255, 255, 255, 255),
                    //       fontWeight: FontWeight.w800,
                    //       shadows: [
                    //         const Shadow(
                    //             offset: Offset(1.0, 1.0),
                    //             blurRadius: 8.0,
                    //             color: Color.fromARGB(255, 231, 211, 27))
                    //       ]),
                    // ),
                    child: Image.asset(
                      "assets/attica_logo.png",
                      scale: 4.0,
                    ),
                  ),
                ],
              )),
          ListTile(
            title: const Text("Home"),
            leading: const Icon(Icons.home),
            onTap: () {
              // Navigator.pop(context);
              // (context.watch<SwithUser>().currUser == "Admin") ? Navigator.popAndPushNamed(context, '/home') : ;
              String userType =
                  Provider.of<SwithUser>(context, listen: false).currUser;
              debugPrint(userType);
              switch (userType) {
                case "Admin":
                  Navigator.popAndPushNamed(context, '/adminHome');
                  break;
                case "Vendor":
                  Navigator.popAndPushNamed(context, '/vendorHome');
                  break;
                case "Photographer":
                  Navigator.popAndPushNamed(context, '/photogHome');
                  break;
              }
            },
          ),
          const Divider(),
          if (context.watch<SwithUser>().currUser == "Vendor")
            ListTile(
              title: const Text("Add Product"),
              leading: const Icon(Icons.add),
              onTap: () {
                // Navigator.pop(context);
                Navigator.popAndPushNamed(context, '/addProd');
              },
            ),
          if (context.watch<SwithUser>().currUser == "Vendor")
            ListTile(
              title: const Text("Add Gold Rate"),
              leading: const Icon(Icons.add),
              onTap: () {
                // Navigator.pop(context);
                Navigator.popAndPushNamed(context, '/addGold');
              },
            ),
          if (context.watch<SwithUser>().currUser == "Photographer")
            ListTile(
              title: const Text("Product Upload"),
              leading: const Icon(Icons.add),
              onTap: () {
                // Navigator.pop(context);
                Navigator.popAndPushNamed(context, '/addImage');
              },
            ),
          if (context.watch<SwithUser>().currUser == "Admin")
            ListTile(
              title: const Text("List Uploaded Products"),
              leading: const Icon(Icons.list_alt_rounded),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const ListProduct())));
              },
            ),
          if (context.watch<SwithUser>().currUser == "Vendor")
            ListTile(
              title: const Text("List My Products"),
              leading: const Icon(Icons.list_alt_rounded),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const ListProductOfVendor())));
              },
            ),
          if (context.watch<SwithUser>().currUser == "Vendor")
            ListTile(
              title: const Text("Photographer Requests"),
              leading: const Icon(Icons.list_alt_rounded),
              onTap: () {
                // Navigator.pop(context);
                Navigator.popAndPushNamed(context, '/listPhoto');
              },
            ),
          if (context.watch<SwithUser>().currUser == "Admin")
            ListTile(
              title: const Text("List Uploaded Images"),
              leading: const Icon(Icons.list_alt_rounded),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const ListImages())));
              },
            ),
          const Divider(),
          ListTile(
            title: const Text("Settings"),
            leading: const Icon(Icons.settings),
            onTap: () {
              // Navigator.pop(context);
              Navigator.popAndPushNamed(context, '/setting');
            },
          ),
          ListTile(
            title: const Text("Logout"),
            leading: const Icon(Icons.logout_rounded),
            onTap: () {
              Navigator.pop(context);
              SharedPreferences.getInstance().then((value) {
                // value.remove('token');
                value.remove('userkey');
                debugPrint("Navbar: Removing userkey");
              });
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: ((context) => const LoginPage())),
                  (route) => false);
            },
          ),
          const Divider(),
          ExpansionTile(
            title: const Text(
              "Test",
              style: TextStyle(color: Colors.red),
            ),
            children: [
              ListTile(
                title: const Text("Home New"),
                leading: const Icon(Icons.home),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: ((context) => const MyHome())),
                      (route) => false);
                },
              ),
              ListTile(
                title: const Text("Test Page"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const TestApp())));
                },
              ),
              ListTile(
                title: const Text("Test 3"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => const Test3())));
                },
              ),
              ListTile(
                title: const Text("Add Product 4"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const AddProduct4())));
                },
              ),
              ListTile(
                title: const Text("Upload Image page"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              const UploadProductProgress())));
                },
              ),
              ListTile(
                title: const Text("Login/SignUp"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const LoginPage())));
                },
              ),
            ],
          ),
          ListTile(
            title: const Text(
              "Switch User",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (context) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              "Current View: ${context.watch<SwithUser>().currUser}"),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/adminHome',
                                    (Route<dynamic> route) => false);
                                context.read<SwithUser>().switchU(0);
                              },
                              child: const Text("Switch to Admin view")),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/vendorHome',
                                    (Route<dynamic> route) => false);
                                context.read<SwithUser>().switchU(1);
                              },
                              child: const Text("Switch to Vendor view")),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/photogHome',
                                    (Route<dynamic> route) => false);
                                context.read<SwithUser>().switchU(2);
                              },
                              child: const Text("Switch to Photographer view")),
                        ],
                      ),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}

class LogoSpin extends StatefulWidget {
  const LogoSpin({super.key, required this.duration});
  final Duration duration;

  @override
  State<LogoSpin> createState() => _LogoSpinState();
}

class _LogoSpinState extends State<LogoSpin>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 18))
        ..repeat();

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = AnimationController(
  //     vsync: this, // the SingleTickerProviderStateMixin
  //     duration: widget.duration,
  //   );
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Transform.rotate(
            angle: _controller.value * 2 * math.pi,
            child: child,
          );
        },
        child: Image.asset(
          "assets/attica_logo.png",
          scale: 4.0,
        ),
      ),
    );
  }
}
