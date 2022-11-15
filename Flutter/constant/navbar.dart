import 'package:ecom/provider/SwitchUser.dart';
import 'package:ecom/register/login.dart';
import 'package:ecom/screens/list_prod.dart';
import 'package:ecom/screens/upload_image.dart';
import 'package:ecom/tests/addprod4.dart';
import 'package:ecom/screens/list_img.dart';
import 'package:ecom/tests/test.dart';
import 'package:ecom/tests/test3.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavDraw extends StatelessWidget {
  const NavDraw({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              // decoration:
              //     const BoxDecoration(color: Color.fromARGB(255, 32, 7, 7)),
              child: Center(
                  child: Text(
            "916 Digital Gold",
            style: GoogleFonts.sacramento(
                fontSize: 28,
                // color: Colors.red,
                color: Colors.blue,
                fontWeight: FontWeight.w800,
                shadows: [
                  const Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 3.0,
                      color: Color.fromARGB(255, 231, 211, 27))
                ]),
          ))),
          ListTile(
            title: const Text("Home"),
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
          if (context.watch<SwithUser>().currUser == "Vendor" ||
              context.watch<SwithUser>().currUser == "Admin")
            ListTile(
              title: const Text("Add Product"),
              onTap: () {
                // Navigator.pop(context);
                Navigator.popAndPushNamed(context, '/addProd');
              },
            ),
          if (context.watch<SwithUser>().currUser == "Admin" ||
              context.watch<SwithUser>().currUser == "Vendor")
            ListTile(
              title: const Text("Add Gold Rate"),
              onTap: () {
                // Navigator.pop(context);
                Navigator.popAndPushNamed(context, '/addGold');
              },
            ),
          if (context.watch<SwithUser>().currUser == "Photographer" ||
              context.watch<SwithUser>().currUser == "Admin")
            ListTile(
              title: const Text("Product Upload"),
              onTap: () {
                // Navigator.pop(context);
                Navigator.popAndPushNamed(context, '/addImage');
              },
            ),
          if (context.watch<SwithUser>().currUser == "Vendor" ||
              context.watch<SwithUser>().currUser == "Admin")
            ListTile(
              title: const Text("List Uploaded Products"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const ListProduct())));
              },
            ),
          if (context.watch<SwithUser>().currUser == "Admin")
            ListTile(
              title: const Text("List Uploaded Images"),
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
            onTap: () {
              // Navigator.pop(context);
              Navigator.popAndPushNamed(context, '/setting');
            },
          ),
          ListTile(
            title: const Text("Logout"),
            onTap: () {
              Navigator.pop(context);
              SharedPreferences.getInstance().then((value) {
                value.remove('token');
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
