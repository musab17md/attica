import 'dart:convert';
import 'dart:io';
import 'package:attica/screens/login_screen.dart';
import 'package:attica/screens/site_visit2.dart';
import 'package:attica/screens/visit_list.dart';
import 'package:attica/ui_elements.dart/api.dart';
import 'package:attica/ui_elements.dart/colors.dart';
import 'package:attica/ui_elements.dart/constants.dart';
import 'package:attica/widgets/attend_count_bar.dart';
import 'package:attica/widgets/date_widget.dart';
import 'package:attica/widgets/location_card2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'ui_elements.dart/details_provider.dart';
import 'ui_elements.dart/loc_provider.dart';
import 'widgets/percentage_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_circular_text/circular_text.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LocationProvider()),
      ChangeNotifierProvider(create: (_) => LiveSwitchProvider()),
      ChangeNotifierProvider(create: (_) => UserDetailProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  setDetail(data) {
    context.read<UserDetailProvider>().setName(data["name"]);
    context.read<UserDetailProvider>().setGroup(data["group"]);

    // get latest app version
    context
        .read<UserDetailProvider>()
        .setAppVersion(int.parse(data["app"].toString()));
  }

  checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    if (token == null) {
      debugPrint(
          "Main: checktoken > Token is null, redirecting to login screen");
      return 'unauth';
    }

    // Test Token
    http.Response response = await getJson('api/list/');
    debugPrint(response.statusCode.toString());
    var data = jsonDecode(response.body);
    setDetail(data);

    // If Server Down
    //TODO: set timeout for http request

    // If wrong credential
    if (data['non_field_errors'] ==
        "Unable to log in with provided credentials.") {
      debugPrint(
          "Main: checktoken > Incorrect Token! removeing now, redirecting to login screen");
      prefs.remove('token');
      return 'unauth';
    }

    // If authenticated
    if (response.statusCode.toString()[0] == "2") {
      debugPrint(
          "Main: checktoken > Token authenticated, redirecting to home screen");
      return 'authenticated';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: checkToken(),
          builder: (context, snapshot) {
            if (snapshot.data == "authenticated") {
              return const MyHomePage();
            }
            if (snapshot.data == "unauth") {
              return const LoginScreen();
            }
            return Scaffold(
              backgroundColor: Colors.grey[850],
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  logout(context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: ((context) => const LoginScreen())),
        (route) => false);
  }

  openFile() async {
    // http://192.168.1.9:8123/media/apk/app-release.apk
    final file = await downloadFile(
        "http://$domain/media/apk/app-release.apk", "application.apk");
    OpenFile.open(file.path);
  }

  downloadFile(url, name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');
    final response = await Dio().get(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
        receiveTimeout: 0,
      ),
    );

    final raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kBackgroundColor,
        title: Text(
          'Welcome, ${Provider.of<UserDetailProvider>(context, listen: true).name}',
          textScaleFactor: 1.0,
        ),
        actions: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 20.0),
          //   child: GestureDetector(
          //     child: const Icon(
          //       Icons.account_circle,
          //       size: 30.0,
          //     ),
          //     onTap: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: ((context) => const ProfileScreen())));
          //     },
          //   ),
          // )
          TextButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: kBackgroundColor,
                        title: const Text(
                          "Logout of App?",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: kWhite),
                        ),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                child: const Text(
                                  "Cancel",
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 30.0,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                child: const Text("Logout"),
                                onPressed: () {
                                  logout(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          controller: ScrollController(),
          physics: const BouncingScrollPhysics(),
          children: [
            const DateWidget(),
            const SizedBox(height: 30),
            if (Provider.of<UserDetailProvider>(context, listen: false).app !=
                appVersion)
              Card(
                color: kCardBackgroundColor,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    const Text(
                      "App update is available!",
                      style: TextStyle(color: kLightGreen),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: kLightRed)),
                      onPressed: () {
                        openFile();
                      },
                      child: const Text(
                        "Download",
                        style: TextStyle(color: kLightRed),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            const SizedBox(height: 30),
            // LocationCard(),
            const LocationCard2(),
            const SizedBox(height: 30),
            // Card(
            //   color: kCardBackgroundColor,
            //   child: Column(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Text(
            //           Provider.of<UserDetailProvider>(context, listen: true)
            //               .group,
            //           style: const TextStyle(color: Colors.white, fontSize: 16),
            //         ),
            //       ),
            //       addSiteButton(context),
            //     ],
            //   ),
            // ),
            if (Provider.of<UserDetailProvider>(context, listen: false).group ==
                "blueskys_users")
              const UserCompany3(),

            // 916_users
            if (Provider.of<UserDetailProvider>(context, listen: false).group ==
                "916_users")
              const UserCompany916(),

            const SizedBox(height: 30),
            const Text(
              "Overall Attendance",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 10),
            const PercentageCard(),
            const SizedBox(height: 20),
            const AttendCountBar(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  OutlinedButton addSiteButton(BuildContext context) {
    return OutlinedButton(
        style:
            OutlinedButton.styleFrom(side: const BorderSide(color: kLightRed)),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const SiteVisit2())));
        },
        child: const Text(
          "Add Site Visit",
          style: TextStyle(color: kLightRed),
        ));
  }
}

class BoxContain extends StatelessWidget {
  const BoxContain({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.amber,
        border: Border.all(color: Colors.blue),
      ),
      child: Center(
          child: Text(
        text,
        style: const TextStyle(color: Colors.red),
      )),
    );
  }
}

class UserCompany extends StatelessWidget {
  const UserCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: kCardBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/blueskys.png",
              width: 100,
            ),
          ),
          Column(
            children: [
              const Text(
                "BlueSkys User",
                style: TextStyle(color: kWhite),
              ),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: kLightRed)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const SiteVisit2())));
                  },
                  child: const Text(
                    "Add Visit",
                    style: TextStyle(color: kLightRed),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

class UserCompany2 extends StatelessWidget {
  const UserCompany2({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: kCardBackgroundColor,
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "BlueSkys User",
            style: TextStyle(color: kWhite),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/blueskys.png",
                  width: 100,
                ),
              ),
              // Container(
              //   height: 100,
              //   width: 100,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(50.0),
              //       border: Border.all(color: kLightGreen)),
              //   child: Center(
              //       child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: const [
              //       Icon(
              //         Icons.add,
              //         color: kLightGreen,
              //       ),
              //       Text(
              //         "Visits",
              //         style: TextStyle(color: kLightGreen),
              //       ),
              //     ],
              //   )),
              // ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kCardBackgroundColor,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(30),
                ),
                onPressed: () {},
                child: const Text(
                  'Add Visit',
                  style: TextStyle(color: kLightGreen),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UserCompany3 extends StatelessWidget {
  const UserCompany3({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: kCardBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Provider.of<UserDetailProvider>(context, listen: false).name,
                  style: const TextStyle(color: kWhite),
                ),
                const Text(
                  "BlueSkys User",
                  style: TextStyle(color: kWhite),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                CircularText(
                  children: [
                    TextItem(
                      text: Text(
                        "Click here to add site visit".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: kLightBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      space: 10,
                      startAngle: -90,
                      startAngleAlignment: StartAngleAlignment.center,
                      direction: CircularTextDirection.clockwise,
                    ),
                  ],
                  radius: 70,
                  position: CircularTextPosition.inside,
                  // backgroundPaint: Paint()..color = Colors.grey.shade200,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const VisitList())));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    elevation: 10,
                    child: Image.asset(
                      "assets/blueskys.png",
                      width: 100,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class UserCompany916 extends StatefulWidget {
  const UserCompany916({super.key});

  @override
  State<UserCompany916> createState() => _UserCompany916State();
}

class _UserCompany916State extends State<UserCompany916> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: kCardBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Provider.of<UserDetailProvider>(context, listen: false)
                        .name,
                    style: const TextStyle(color: kWhite),
                  ),
                  const Text(
                    "916 Digital Gold",
                    style: TextStyle(color: kWhite),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/logo.png",
                width: 100,
              ),
            )
          ],
        ),
      ),
    );
  }
}
