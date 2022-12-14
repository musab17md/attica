import 'dart:convert';

import 'package:attica/main.dart';
import 'package:attica/ui_elements.dart/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../ui_elements.dart/colors.dart';
import '../ui_elements.dart/gps_locate.dart';

class SiteVisit extends StatefulWidget {
  const SiteVisit({super.key});

  @override
  State<SiteVisit> createState() => _SiteVisitState();
}

class _SiteVisitState extends State<SiteVisit> {
  final numberController = TextEditingController();
  final otpController = TextEditingController();
  String otp = "";
  String id = "";

  getLoc() async {
    var loc = await determinePosition();
    return loc;
  }

  sendingDialog() {
    showDialog(
        context: context,
        builder: ((context) {
          return const Center(
            child: Card(
                child: Padding(
              padding: EdgeInsets.all(18.0),
              child: Text("Sending OTP. . ."),
            )),
          );
        }));
  }

  errorDialog() {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text(
                "Incorrect number format, required 10 digits number"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Okay"))
            ],
          );
        }));
  }

  customDialog(title, txt, buttontxt, func) {
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
                    if (func != null) {
                      func();
                    }
                  },
                  child: Text(
                    buttontxt,
                    style: const TextStyle(color: kWhite),
                  ))
            ],
          );
        }));
  }

  postNumber() async {
    var loc = await getLoc();
    http.Response response = await postJson('api/api_sites/', {
      "mobile": numberController.text,
      "place": "latitude:${loc.latitude}, longitude:${loc.longitude}"
    });
    var body = jsonDecode(response.body);
    return body;
  }

  sendPostNum() async {
    if (numberController.text.length == 10 &&
        int.tryParse(numberController.text) != null) {
      sendingDialog();
      var body = await postNumber();
      otp = body["object"]["otp"];
      id = body["object"]["id"].toString();
      debugPrint(otp);
      Navigator.pop(context);
    } else {
      errorDialog();
    }
  }

  postOtp() async {
    http.Response response = await postJson('api/api_sites_auth/', {
      "id": id,
    });
    return response;
  }

  resetToHome() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: ((context) => const MyHomePage())),
        (route) => false);
  }

  sendPostOtp() async {
    if (otp == otpController.text) {
      sendingDialog();
      var result = await postOtp();
      Navigator.pop(context);
      if (jsonDecode(result.body)['status'] == "success") {
        customDialog(
            "Success", "Added site visit successfully", "Okay", resetToHome);
      } else {
        customDialog("Error", "An Error occurred", "Retry", null);
      }
    } else {
      errorDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kBackgroundColor,
        title: const Text(
          'Add Site Visit',
          textScaleFactor: 1.0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 100),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: kCardBackgroundColor,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: MyTextField(
                        text: 'Enter Mobile Number',
                        controller: numberController,
                      )),
                      const SizedBox(width: 10),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: kLightRed)),
                          onPressed: () {
                            sendPostNum();
                          },
                          child: const Text(
                            "Send OTP",
                            style: TextStyle(color: kLightRed),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(
              color: kLightGreen,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    width: 100,
                    child: MyTextField(
                      text: 'Enter OTP',
                      controller: otpController,
                    )),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: kLightRed)),
                    onPressed: () {
                      sendPostOtp();
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: kLightRed),
                    )),
              ],
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({super.key, required this.text, required this.controller});
  final String text;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: kLightGreen),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: kLightGreen, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: kLightGreen),
            ),
            labelStyle: const TextStyle(color: kLightGreen),
            labelText: text),
      ),
    );
  }
}
