import 'dart:convert';

import 'package:attica/main.dart';
import 'package:attica/ui_elements.dart/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = "";
  String password = "";

  login() async {
    showDialog(
        context: context,
        builder: ((context) {
          return const AlertDialog(
            content: Text("Logging you in. . ."),
          );
        }));
    http.Response response = await getToken(username, password);
    Navigator.pop(context);
    if (response.statusCode.toString()[0] == "2") {
      saveToken(jsonDecode(response.body)['token']);
    } else {
      wrongCred();
    }
  }

  wrongCred() {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Wrong Credentials"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Back"))
            ],
          );
        }));
  }

  homeScreen() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: ((context) => const MyApp())),
        (route) => false);
  }

  saveToken(token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    homeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/background2.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.only(left: 35, top: 80),
            child: const Text(
              "Welcome\nBack",
              style: TextStyle(color: Colors.white, fontSize: 33),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  right: 35,
                  left: 35,
                  top: MediaQuery.of(context).size.height * 0.5),
              child: Column(children: [
                TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) {
                    username = value;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Color(0xff4c505b),
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color(0xff4c505b),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          if (username != "" && password != "") {
                            login();
                          }
                        },
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
