import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavDraw extends StatelessWidget {
  const NavDraw({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Center(
                  child: Text(
                "916 Digital Gold",
                style: GoogleFonts.sacramento(
                    fontSize: 28,
                    color: Colors.red,
                    shadows: [
                      const Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 138, 129, 52))
                    ]),
              ))),
          ListTile(
            title: const Text("Home"),
            onTap: () {
              // Navigator.pop(context);
              Navigator.popAndPushNamed(context, '/home');
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Add Product"),
            onTap: () {
              // Navigator.pop(context);
              Navigator.popAndPushNamed(context, '/addProd');
            },
          ),
          ListTile(
            title: const Text("Add Gold Rate"),
            onTap: () {
              // Navigator.pop(context);
              Navigator.popAndPushNamed(context, '/addGold');
            },
          ),
          ListTile(
            title: const Text("Product Upload"),
            onTap: () {
              // Navigator.pop(context);
              Navigator.popAndPushNamed(context, '/addImage');
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

          // ListTile(
          //   title: const Text("Logout"),
          //   onTap: () {
          //     Navigator.pop(context);
          //     SharedPreferences.getInstance().then((value) {
          //       value.remove('token');
          //     });
          //     Navigator.pushAndRemoveUntil(
          //         context,
          //         MaterialPageRoute(builder: ((context) => const LoginPage())),
          //         (route) => false);
          //   },
          // ),

          // ListTile(
          //   title: const Text("Login/SignUp"),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: ((context) => const LoginPage())));
          //   },
          // ),

          // ListTile(
          //   title: const Text("List Product"),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: ((context) => const ListProduct())));
          //   },
          // ),

          // ListTile(
          //   title: const Text("Test Page"),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: ((context) => const TestApp())));
          //   },
          // ),
        ],
      ),
    );
  }
}
