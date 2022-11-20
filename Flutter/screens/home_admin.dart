import 'dart:convert';

import 'package:attica/constant/navbar.dart';
import 'package:attica/core/api_client.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDraw(),
      appBar: AppBar(
        title: const Text("916 Digital Gold"),
      ),
      body: const AdHome(),
    );
  }
}

class AdHome extends StatefulWidget {
  const AdHome({super.key});

  @override
  State<AdHome> createState() => _AdHomeState();
}

class _AdHomeState extends State<AdHome> {
  getUser() async {
    // final prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString("token");

    ApiClient().userType();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Home Page (Admin)"),
          ElevatedButton(
              onPressed: () {
                getUser();
              },
              child: Text("data"))
        ],
      ),
    );
  }
}
