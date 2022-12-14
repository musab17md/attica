import 'dart:convert';
import 'dart:math';

import 'package:attica/ui_elements.dart/api.dart';
import 'package:attica/ui_elements.dart/gps_locate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../ui_elements.dart/colors.dart';

class SiteVisit2 extends StatefulWidget {
  const SiteVisit2({super.key});

  @override
  State<SiteVisit2> createState() => _SiteVisit2State();
}

class _SiteVisit2State extends State<SiteVisit2> {
  List<String> suggestons = [];
  TextEditingController selectController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Random random = Random();
  int result = 0;

  getData() async {
    http.Response response = await getJson("api/pending_sites/");
    var data = jsonDecode(response.body);
    for (var d in data["sites"]) {
      debugPrint(d['name']);
      suggestons.add("${d['number']}\n${d['name']} | ${d['address']}");
    }
    return "success";
  }

  randomNum() {
    int min = 101858, max = 957445;
    result = min + random.nextInt(max - min);
    // Send otp Api here
    postOtp(selectController.text, result);
    debugPrint(result.toString());
  }

  // verifyOtp() {
  //   randomNum();
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: const Text("Enter OTP"),
  //           content: TextFormField(
  //             controller: otpController,
  //             keyboardType: TextInputType.number,
  //             validator: (String? value) {
  //               if (otpController.text == result.toString()) {
  //                 return null;
  //               } else {
  //                 return "Entered otp is incorrect.";
  //               }
  //             },
  //           ),
  //           actions: [
  //             ElevatedButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: const Text("Back"),
  //             ),
  //             ElevatedButton(
  //               onPressed: () {
  //               },
  //               child: const Text("Verify"),
  //             ),
  //           ],
  //         );
  //       });
  // }

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

  postVisit() async {
    // Show loading dialog
    loadingDialog("Adding Site. . .");
    String place = await getCoor();
    var data = {'mobile': selectController.text, 'place': place};
    http.Response response = await postJson("api/api_add_site_visit/", data);
    // pop loading and show success dialog
    successDialog();
  }

  verifyOtp() {
    if (selectController.text.length != 10) {
      return errorDialog("Error", "Required 10 digits mobile number");
    }
    randomNum();
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

                              postVisit();
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
        title: const Text("Site Visit"),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                SuggestedField(
                  suggestons: suggestons,
                  selectController: selectController,
                ),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: kLightRed)),
                    onPressed: () {
                      debugPrint(selectController.text);
                      verifyOtp();
                    },
                    child: const Text(
                      "Send OTP",
                      style: TextStyle(color: kLightRed),
                    ))
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class SuggestedField extends StatefulWidget {
  SuggestedField({
    Key? key,
    required this.suggestons,
    required this.selectController,
  }) : super(key: key);

  final List<String> suggestons;
  TextEditingController selectController;

  @override
  State<SuggestedField> createState() => _SuggestedFieldState();
}

class _SuggestedFieldState extends State<SuggestedField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Autocomplete(
        optionsBuilder: (textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<String>.empty();
          } else {
            List<String> matches = <String>[];
            matches.addAll(widget.suggestons);

            matches.retainWhere(
              (s) {
                return s
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase());
              },
            );
            return matches;
          }
        },
        fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              onEditingComplete: onEditingComplete,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  labelText: "Enter Number",
                  labelStyle: const TextStyle(color: Colors.grey),
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
                  prefixIcon: const Icon(Icons.phone_android_outlined)),
              onChanged: (value) {
                widget.selectController.text = value;
              },
            ),
          );
        },
        onSelected: (option) {
          widget.selectController.text = option.split("\n")[0];
        },
      ),
    );
  }
}
