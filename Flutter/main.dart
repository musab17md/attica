import 'package:ecom/core/api_client.dart';
import 'package:ecom/provider/SwitchUser.dart';
import 'package:ecom/register/login.dart';
import 'package:ecom/screens/add_prod_3.dart';
import 'package:ecom/screens/home.dart';
import 'package:ecom/screens/home_admin.dart';
import 'package:ecom/screens/home_photog.dart';
import 'package:ecom/screens/home_vendor.dart';
import 'package:ecom/screens/list_img.dart';
import 'package:ecom/screens/list_photo_by_id.dart';
import 'package:ecom/screens/list_prod.dart';
import 'package:ecom/screens/list_prod_by_id.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constant/settings.dart';
import 'core/theme.dart';
import 'provider/AddProductForm.dart';
import 'screens/add_gold_rate.dart';
import 'screens/add_image.dart';

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

  checkUser() async {
    final prefs = await SharedPreferences.getInstance();
    debugPrint("Main: Checking userkey in sharedpref");
    List? keys = prefs.getStringList('userkey');
    debugPrint("Main: sharedpref keys > $keys");
    if (keys == null) {
      debugPrint("Main: userKey list is null. Returning to login");
      return "login";
    }
    Response response = await ApiClient().login2(keys[2], keys[3]);
    if (keys[7] == "0") {
      debugPrint("Main: user inactive returning inactive page");
      return "inactive";
    }
    if (response.statusCode == 404) {
      debugPrint("Main: response.statusCode == 404. Returning to login");
      return "login";
    }
    return "home";
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
        '/adminHome': (BuildContext context) => const AdminHome(),
        '/vendorHome': (BuildContext context) => const VendorHome(),
        '/photogHome': (BuildContext context) => const PhotoHome(),
        '/home': (BuildContext context) => const MyHome(),
        '/addProd': (BuildContext context) => const AddProduct3(),
        '/listAllProd': (BuildContext context) => const ListProduct(),
        '/listProdOfVendor': (BuildContext context) =>
            const ListProductOfVendor(),
        '/listPhoto': (BuildContext context) => const ListPhotoByID(),
        '/addGold': (BuildContext context) => const AddGoldRate(),
        '/addImage': (BuildContext context) => const AddProductImage(),
        '/listImage': (BuildContext context) => const ListImages(),
        '/setting': (BuildContext context) => const Settings(),
      },
      home: FutureBuilder(
          // future: getToken(),
          future: checkUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == "login") {
              debugPrint("Main: snapshot.data is null redirecting login page");
              return const LoginPage();
              // return const MyHome();
            }
            if (snapshot.data == "home") {
              debugPrint("Main: snapshot.data redirecting Home");
              return const MyHome();
            }
            if (snapshot.data == "inactive") {
              debugPrint("Main: snapshot.data redirecting Inactive");
              return const Inactive();
            }

            debugPrint(
                "Main: snapshot.loading == showing CircularProgressIndicator");
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }),
    );
  }
}

class Inactive extends StatelessWidget {
  const Inactive({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.sick_rounded,
              size: 130,
            ),
            SizedBox(
              height: 20,
            ),
            Center(child: Text("Inactive User, Please contact admin.")),
          ],
        ),
      ),
    );
  }
}
