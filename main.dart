import 'package:ecom/addgoldrate.dart';
import 'package:ecom/addimage.dart';
import 'package:ecom/login.dart';
import 'package:ecom/navbar.dart';
import 'package:ecom/provider/AddProductForm.dart';
import 'package:ecom/settings.dart';
import 'package:ecom/testhome.dart';
import 'package:ecom/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'addprod3.dart';
import 'home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    var savedTheme = prefs.getBool('theme') ?? false;
    debugPrint(savedTheme.toString());
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => ThemeChanger(
                  savedTheme ? ThemeData.dark() : ThemeData.light())),
          ChangeNotifierProvider(create: (_) => UpdateNetAmount()),
        ],
        child: const MyApp(),
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    return token;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme(),
      title: 'ATTICA',
      routes: <String, WidgetBuilder>{
        '/main': (BuildContext context) => const MyApp(),
        '/home': (BuildContext context) => const MyHome(),
        '/addProd': (BuildContext context) => const AddProduct3(),
        '/addGold': (BuildContext context) => const AddGoldRate(),
        '/addImage': (BuildContext context) => const AddProductImage(),
        '/setting': (BuildContext context) => const Settings(),
      },
      home: FutureBuilder(
          future: getToken(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              // return const LoginPage();
              return const MyHome();
            } else {
              return const MyHome();
            }
          }),
    );
  }
}
