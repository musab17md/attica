import 'dart:convert';
import 'dart:math';

import 'package:attica/ui_elements.dart/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../ui_elements.dart/colors.dart';
import '../ui_elements.dart/gps_locate.dart';

class VisitList extends StatefulWidget {
  const VisitList({super.key});

  @override
  State<VisitList> createState() => _VisitListState();
}

class _VisitListState extends State<VisitList> {
  var numberList = [];

  TextEditingController otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Random random = Random();
  int result = 0;

  getNumbers() async {
    http.Response response = await getJson("api/mysites/");
    numberList = jsonDecode(response.body)['sites'];
    return "success";
  }

  loadingDialog(txt) {
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

  errorDialog(title, body) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(body),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Okay"))
            ],
          );
        });
  }

  successDialog() {
    Navigator.pop(context);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: ((context) {
          return AlertDialog(
            backgroundColor: kBackgroundColor,
            content: const Text(
              "Site added successfully",
              style: TextStyle(color: kWhite),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  // Navigator.pushAndRemoveUntil(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: ((context) => const MyHomePage())),
                  //     (route) => false);
                },
                child: const Text("Okay"),
              ),
            ],
          );
        }));
  }

  getCoor() async {
    var loc = await determinePosition();
    return loc.toString();
  }

  randomNum(number) {
    int min = 101858, max = 957445;
    result = min + random.nextInt(max - min);
    // Send otp Api here
    postOtp(number, result);
    debugPrint(result.toString());
  }

  postVisit(number) async {
    // Show loading dialog
    loadingDialog("Adding Site. . .");
    String place = await getCoor();
    var data = {'mobile': number, 'place': place};
    http.Response response = await postJson("api/api_add_site_visit/", data);
    // pop loading and show success dialog
    successDialog();
  }

  verifyOtp(number) {
    if (number.length != 10) {
      return errorDialog("Error", "Required 10 digits mobile number");
    }
    randomNum(number);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kCardBackgroundColor,
              ),
              width: width - 100,
              height: 200,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, left: 20),
                        child: Text(
                          "OTP Sent",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          label: const Text(
                            "Enter OTP",
                            style: TextStyle(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          prefixIcon: const Icon(
                            Icons.key,
                            color: Colors.grey,
                          ),
                        ),
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        validator: (String? value) {
                          if (otpController.text == result.toString()) {
                            return null;
                          } else {
                            return "Entered otp is incorrect.";
                          }
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: kLightRed)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Back",
                            style: TextStyle(color: kLightRed),
                          ),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: kLightRed)),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              debugPrint("otp is verified and posting api ");
                              Navigator.pop(context);

                              postVisit(number);
                            }
                          },
                          child: const Text(
                            "Verify",
                            style: TextStyle(color: kLightRed),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kBackgroundColor,
        title: const Text(
          'Sites',
          textScaleFactor: 1.0,
        ),
      ),
      body: FutureBuilder(
          future: getNumbers(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: numberList.length,
                itemBuilder: (context, i) {
                  return Card(
                    color: kCardBackgroundColor,
                    child: ExpansionTile(
                      title: Text(
                        numberList[i]["name"].toString(),
                        style: const TextStyle(color: kWhite),
                      ),
                      subtitle: Text(
                        numberList[i]["number"].toString(),
                        style: const TextStyle(color: kWhite),
                      ),
                      children: [
                        ListTile(
                          title: Text(
                            numberList[i]["address"].toString(),
                            style: const TextStyle(color: kLightGreen),
                          ),
                          trailing: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: kLightRed)),
                            onPressed: () {
                              verifyOtp(numberList[i]["number"].toString());
                            },
                            child: const Text(
                              "Send Otp",
                              style: TextStyle(color: kLightRed),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          })),
    );
  }
}
