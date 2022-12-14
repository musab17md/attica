import 'dart:async';
import 'dart:convert';

import 'package:attica/ui_elements.dart/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../ui_elements.dart/colors.dart';
import '../ui_elements.dart/gps_locate.dart';
import '../ui_elements.dart/loc_provider.dart';

class LocationCard extends StatefulWidget {
  const LocationCard({super.key});

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard>
    with SingleTickerProviderStateMixin {
  bool loggedin = true;
  bool loggedout = true;
  bool refreshClicked = false;
  late final AnimationController _controller;

  loginDialog(txt) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: ((context) {
          return AlertDialog(
            backgroundColor: kBackgroundColor,
            content: Text(
              txt,
              style: const TextStyle(color: kWhite),
            ),
          );
        }));
  }

  inOfficeDialog(title, txt) {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            backgroundColor: kBackgroundColor,
            title: Text(
              title,
              style: const TextStyle(color: kLightRed),
            ),
            content: Text(
              txt,
              style: const TextStyle(color: kLightRed),
            ),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kCardBackgroundColor),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "No",
                    style: TextStyle(color: kWhite),
                  ))
            ],
          );
        }));
  }

  setLogState(data) {
    // debugPrint("LocationCard>setLogState: $data");
    loggedin = true;
    loggedout = true;
    Navigator.pop(context);
    setState(() {});
  }

  setLocProv(val) => context.read<LocationProvider>().setLocation(val);

  liveLocNow() async {
    double distanceInMeters = await getDistInMeter();
    String locText = getLocText(distanceInMeters);
    setLocProv(locText);
  }

  logInNow() async {
    loginDialog("Logging you in. . .");
    await liveLocNow();
    if (Provider.of<LocationProvider>(context, listen: false).curloc ==
            nearOffice ||
        Provider.of<LocationProvider>(context, listen: false).curloc ==
            atOffice) {
      http.Response response = await getJson("api/api_login/");
      debugPrint("LocationCard: loginNow completed");
      var data = jsonDecode(response.body);
      setLogState(data);
    } else {
      Navigator.pop(context);
      inOfficeDialog("Location Error", "Are you in Office?");
    }
  }

  logOutNow() async {
    loginDialog("Logging you out. . .");
    await liveLocNow();
    if (Provider.of<LocationProvider>(context, listen: false).curloc ==
            nearOffice ||
        Provider.of<LocationProvider>(context, listen: false).curloc ==
            atOffice) {
      http.Response response = await getJson("api/api_logout/");
      debugPrint("LocationCard: loginNow completed");
      var data = jsonDecode(response.body);
      setLogState(data);
    } else {
      Navigator.pop(context);
      inOfficeDialog("Location Error", "Are you in Office?");
    }
  }

  getLoggedStat() async {
    http.Response response = await getJson("api/logs_today/");
    var data = jsonDecode(response.body);
    debugPrint(data.toString());
    debugPrint(data['logout']);
    loggedin = data['login'] == "0" ? false : true;
    loggedout = data['logout'] == "0" ? false : true;
    _controller.reset();
  }

  loadCard() async {
    var d = await getLoggedStat();
    return "done";
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // _controller.forward();
    // Run the animation once, use .forward
    //Loop the animation, use .repeat
    //Stop immediately, use .stop
    //Stop and set it back to original rotation, use .reset
    //Stop and animate to a rotation value, use .animateTo
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadCard(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: kCardBackgroundColor,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: LiveLocation(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: loggedout
                            ? const Text(
                                "You are done for the day.",
                                style: TextStyle(color: kWhite),
                              )
                            : loggedin
                                ? const Text(
                                    "You are currently logged in.",
                                    style: TextStyle(color: kWhite),
                                  )
                                : const Text(
                                    "You are not logged in.",
                                    style: TextStyle(color: kWhite),
                                  ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    color: loggedin ? kLightBlue : kLightRed)),
                            onPressed: () {
                              // loggedin = true;
                              !loggedin ? logInNow() : null;
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.login,
                                  color: loggedin ? kLightBlue : kLightRed,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Login",
                                  style: TextStyle(
                                      color: loggedin ? kLightBlue : kLightRed),
                                ),
                              ],
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    color: loggedout ? kLightBlue : kLightRed)),
                            onPressed: () {
                              // loggedin = false;
                              !loggedout ? logOutNow() : null;
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: loggedout ? kLightBlue : kLightRed,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Logout",
                                  style: TextStyle(
                                      color:
                                          loggedout ? kLightBlue : kLightRed),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: refreshButton(),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Live",
                        style: TextStyle(
                            color: context.watch<LiveSwitchProvider>().liveS
                                ? kRed
                                : kLightGreen),
                      ),
                      SizedBox(
                        height: 20,
                        width: 50,
                        // decoration: const BoxDecoration(color: Colors.blue),
                        child: Switch(
                            value: context.watch<LiveSwitchProvider>().liveS,
                            onChanged: (bool value) {
                              // liveSwitch = value;
                              context
                                  .read<LiveSwitchProvider>()
                                  .setSwitch(value);
                              debugPrint(
                                  "live switch is ${Provider.of<LiveSwitchProvider>(context, listen: false).liveS}");
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: kCardBackgroundColor,
            child: const SizedBox(
              height: 150,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }));
  }

  Widget refreshButton() {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: IconButton(
          onPressed: () {
            _controller.repeat();
            setState(() {});
          },
          icon: const Icon(
            Icons.refresh,
            color: kCardBackgroundColor,
          )),
    );
  }
}

class LiveLocation extends StatefulWidget {
  const LiveLocation({super.key});

  @override
  State<LiveLocation> createState() => _LiveLocationState();
}

class _LiveLocationState extends State<LiveLocation> {
  late Timer timer;

  // getLoc() async {
  //   var loc = await determinePosition();
  //   double distanceInMeters = Geolocator.distanceBetween(
  //       12.98389, 77.61731, loc.latitude, loc.longitude);
  //   debugPrint(loc.toString());
  //   debugPrint("Latitude : ${loc.latitude}");
  //   debugPrint("longitude : ${loc.longitude}");
  //   debugPrint("Distance : $distanceInMeters");
  //   getLocText(distanceInMeters);
  //   setState(() {});
  // }

  setLocProv(val) => context.read<LocationProvider>().setLocation(val);

  getLoc() async {
    double distanceInMeters = await getDistInMeter();
    String text = getLocText(distanceInMeters);
    setLocProv(text);
    if (text == atOffice) {
      locColor = kLightGreen;
    }
    if (text == nearOffice) {
      locColor = kLightGreen;
    }
    if (text == farOffice) {
      locColor = kRed;
    }
    if (text == notOffice) {
      locColor = kRed;
    }
  }

  Color? locColor = Colors.blue;

  // getLocText(double val) {
  //   if (val <= 7.0) {
  //     debugPrint("val <= 7.0, $atOffice");
  //     // currLoc = atOffice;
  //     context.read<LocationProvider>().setLocation(atOffice);
  //     locColor = kLightGreen;
  //     return;
  //   }
  //   if (val <= 15.0) {
  //     debugPrint("val <= 15.0, $nearOffice");
  //     // currLoc = nearOffice;
  //     context.read<LocationProvider>().setLocation(nearOffice);
  //     locColor = kLightGreen;
  //     return;
  //   }
  //   if (val <= 50.0) {
  //     debugPrint("val <= 50.0, $farOffice");
  //     // currLoc = farOffice;
  //     context.read<LocationProvider>().setLocation(farOffice);
  //     locColor = kRed;
  //     return;
  //   } else {
  //     debugPrint("val is more then 50.0, $notOffice");
  //     // currLoc = notOffice;
  //     context.read<LocationProvider>().setLocation(notOffice);
  //     locColor = kRed;
  //   }
  // }

  @override
  void initState() {
    getLoc();
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 15), (Timer t) {
      if (Provider.of<LiveSwitchProvider>(context, listen: false).liveS) {
        getLoc();
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var result = getLoc();
        debugPrint(result.toString());
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_on,
            color: locColor,
            size: 18,
          ),
          Text(
            context.watch<LocationProvider>().curloc,
            style: TextStyle(color: locColor),
          ),
        ],
      ),
    );
  }
}
