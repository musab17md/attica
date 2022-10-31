import 'package:ecom/login.dart';
import 'package:ecom/settings.dart';
import 'package:ecom/test.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'addprod.dart';
import 'listprod.dart';
import 'main.dart';

class NavDraw extends StatelessWidget {
  const NavDraw({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("Navigate")),
          ListTile(
            title: const Text("Home"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const MyApp())));
            },
          ),
          ListTile(
            title: const Text("Settings"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const Settings())));
            },
          ),
          // ListTile(
          //   title: const Text("Login/SignUp"),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: ((context) => const LoginPage())));
          //   },
          // ),
          ListTile(
            title: const Text("Add Product"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const AddProduct())));
            },
          ),
          ListTile(
            title: const Text("List Product"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const ListProduct())));
            },
          ),
          ListTile(
            title: const Text("Test"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const MyStatefulWidget())));
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
        ],
      ),
    );
  }
}
