import 'package:ecom/core/api_client.dart';
import 'package:ecom/provider/SwitchUser.dart';
import 'package:ecom/register/login.dart';
import 'package:ecom/screens/add_prod_3.dart';
import 'package:ecom/screens/home_admin.dart';
import 'package:ecom/screens/home_photog.dart';
import 'package:ecom/screens/home_vendor.dart';
import 'package:ecom/screens/list_img.dart';
import 'package:ecom/screens/list_prod.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constant/settings.dart';
import 'core/theme.dart';
import 'provider/AddProductForm.dart';
import 'screens/add_gold_rate.dart';
import 'screens/add_image.dart';
import 'screens/home.dart';

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
          ChangeNotifierProvider(create: (_) => SwithUser()),
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
    String? token = prefs.getString('token');
    debugPrint(token);
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
        '/adminHome': (BuildContext context) => const AdminHome(),
        '/vendorHome': (BuildContext context) => const VendorHome(),
        '/photogHome': (BuildContext context) => const PhotoHome(),
        '/addProd': (BuildContext context) => const AddProduct3(),
        '/listProd': (BuildContext context) => const ListProduct(),
        '/addGold': (BuildContext context) => const AddGoldRate(),
        '/addImage': (BuildContext context) => const AddProductImage(),
        '/listImage': (BuildContext context) => const ListImages(),
        '/setting': (BuildContext context) => const Settings(),
      },
      home: FutureBuilder(
          future: getToken(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const LoginPage();
              // return const MyHome();
            } else {
              return const MyHome();
            }
          }),
    );
  }
}
