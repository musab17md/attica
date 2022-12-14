import 'package:attica/ui_elements.dart/loc_provider.dart';
import 'package:geolocator/geolocator.dart';

import 'package:app_settings/app_settings.dart';

openLocationSetting() {
  AppSettings.openLocationSettings();
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
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

getDistInMeter() async {
  // Location location = Location();
  // bool ison = await location.serviceEnabled();
  // if (!ison) {
  //   //if defvice is off
  //   bool isturnedon = await location.requestService();
  //   if (isturnedon) {
  //     print("GPS device is turned ON");
  //   } else {
  //     print("GPS Device is still OFF");
  //     exit(0);
  //   }
  // }
  var loc = await determinePosition();
  double distanceInMeters = Geolocator.distanceBetween(
      12.98389, 77.61731, loc.latitude, loc.longitude);
  print(loc.toString());
  print("Latitude : ${loc.latitude}");
  print("longitude : ${loc.longitude}");
  print("Distance : $distanceInMeters");
  return distanceInMeters;
}

getLocText(double val) {
  if (val <= 7.0) {
    print("val <= 7.0, $atOffice");
    return atOffice;
  }
  if (val <= 15.0) {
    print("val <= 15.0, $nearOffice");
    return nearOffice;
  }
  if (val <= 50.0) {
    print("val <= 50.0, $farOffice");
    return farOffice;
  } else {
    print("val is more then 50.0, $notOffice");
    return notOffice;
  }
}
