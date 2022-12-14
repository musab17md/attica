import 'dart:async';
import 'dart:convert';

import 'package:app_settings/app_settings.dart';
import 'package:attica/ui_elements.dart/colors.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import '../ui_elements.dart/api.dart';
import '../ui_elements.dart/loc_provider.dart';

class LocationCard2 extends StatefulWidget {
  const LocationCard2({super.key});

  @override
  State<LocationCard2> createState() => _LocationCard2State();
}

class _LocationCard2State extends State<LocationCard2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool loggedin = true;
  bool loggedout = true;
  late Timer timer;
  setLocProv(val) => context.read<LocationProvider>().setLocation(val);

  openLocationSetting() {
    AppSettings.openLocationSettings();
  }

  showNoGpsDialog() {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text("GPS access"),
            content: const Text("Please enable Gps location to continue."),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  openLocationSetting();
                },
                child: const Text("GPS access"),
              )
            ],
          );
        }));
  }

  determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      // return Future.error('Location services are disabled.');
      // showNoGpsDialog();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  getLocx() async {
    await showNoGpsDialog();
  }

  getDistInMeter() async {
    var loc = await determinePosition();
    double distanceInMeters = Geolocator.distanceBetween(
        12.98389, 77.61731, loc.latitude, loc.longitude);
    debugPrint(loc.toString());
    debugPrint("Latitude : ${loc.latitude}");
    debugPrint("longitude : ${loc.longitude}");
    debugPrint("Distance : $distanceInMeters");
    return distanceInMeters;
  }

  getLocText(double val) {
    if (val <= 7.0) {
      debugPrint("val <= 7.0, $atOffice");
      return atOffice;
    }
    if (val <= 15.0) {
      debugPrint("val <= 15.0, $nearOffice");
      return nearOffice;
    }
    if (val <= 50.0) {
      debugPrint("val <= 50.0, $farOffice");
      return farOffice;
    } else {
      debugPrint("val is more then 50.0, $notOffice");
      return notOffice;
    }
  }

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
    setState(() {});
    Navigator.pop(context);
  }

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
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: GestureDetector(
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
                        ),
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
                  child: RotationTransition(
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
                  ),
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
}
