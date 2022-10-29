import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'navbar.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

postLogin(user, pass) async {
  final prefs = await SharedPreferences.getInstance();
  debugPrint("Login: response start");
  var authEndpoint = "http://192.168.0.134:8080/auth/";

  Map data = {
    'username': user,
    'password': pass,
  };
  var body = json.encode(data);
  var response = await http
      .post(
    Uri.parse(authEndpoint),
    headers: {"Content-Type": "application/json"},
    body: body,
  )
      .timeout(const Duration(seconds: 10));
  debugPrint("Login: response returned");
  var jsonData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    await prefs.setString('token', jsonData["token"]);
    debugPrint("Login: Saved token to sharedpref");
    debugPrint(jsonData["token"]);
    return "true";
  }
  debugPrint("Login: ${response.body}");
  debugPrint("Login: ${response.statusCode.toString()}");
  debugPrint("Login: ${jsonData.toString()}");
  debugPrint("Login: ${jsonData["token"]}");
  debugPrint("Login: End of post login function");
  return "false";
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> loadingStat = ValueNotifier<bool>(false);
  bool _signInActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login / Sign Up"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(child: Column(
              children: const [
                Text("916 DIGITAL GOLD", style: TextStyle(fontSize: 40.0),),
                Text("BUY ONLINE GOLD"),
              ],
            ),),
            const SizedBox(height: 80,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:  [
                TextButton(onPressed: () {
                  setState(() {
                    _signInActive = true;
                  });
                }, child: Text("SIGN IN", style: TextStyle(fontSize: _signInActive ? 25.00 : 15.00,),)),
                TextButton(onPressed: () {
                  setState(() {
                    _signInActive = false;
                  });
                }, child: Text("SIGN UP", style: TextStyle(fontSize: _signInActive ? 15.00 : 25.00,),)),
              ],
            ),
            const SizedBox(height: 40,),
            Container(
              child: _signInActive ? showSignIn() : showSignUp(),
            ),
          ],
        ),
    );
  }
  Widget showSignIn() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email)
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock)
              ),
            ),
            const SizedBox(height: 40,),
            ElevatedButton(
              onPressed: () {
                postLogin(nameController.text,
                    passwordController.text).then((result){
                  debugPrint("Login: $result");

                  loadingStat.value = false;
                  if (result == "true") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const MyApp())));
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(260, 50) // put the width and height you want
              ),
              child: const Text("Sign In", style: TextStyle(fontSize: 25.00,),),
            ),
          ],
        ),
      ),
    );
  }
  Widget showSignUp() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                  hintText: "Enter Your Email",
                  prefixIcon: Icon(Icons.email)
              ),
            ),
            const SizedBox(height: 20,),
            const TextField(
              decoration: InputDecoration(
                  hintText: "Create New Password",
                  prefixIcon: Icon(Icons.lock)
              ),
            ),
            const SizedBox(height: 20,),
            const TextField(
              decoration: InputDecoration(
                  hintText: "Re-Enter Password",
                  prefixIcon: Icon(Icons.lock)
              ),
            ),
            const SizedBox(height: 40,),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(260, 50) // put the width and height you want
              ),
              child: const Text("Sign Up", style: TextStyle(fontSize: 25.00,),),
            ),
          ],
        ),
      ),
    );
  }
}
