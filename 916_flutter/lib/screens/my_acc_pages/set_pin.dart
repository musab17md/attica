import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../ui_elements/colors.dart';
import '../../ui_elements/widget_style.dart';
import '../../widgets/app_bar.dart';

class SetPin extends StatefulWidget {
  const SetPin({super.key});

  @override
  State<SetPin> createState() => _SetPinState();
}

class _SetPinState extends State<SetPin> {
  TextEditingController mpin1 = TextEditingController();
  TextEditingController mpin2 = TextEditingController();

  setPin(pin) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? creds = prefs.getStringList('credentials');
    creds![1] = pin;
    prefs.setStringList('credentials', creds);
    debugPrint("setPin: New pin saved");
  }

  removePin() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? creds = prefs.getStringList('credentials');
    creds![1] = "";
    prefs.setStringList('credentials', creds);
    debugPrint("removePin: Removed Pin");
  }

  getCred() async {
    final prefs = await SharedPreferences.getInstance();
    String creds = prefs.getStringList('credentials')![1];
    return creds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: const MyAppBar2(
        title: "Set M-Pin",
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder(
                  future: getCred(),
                  builder: ((context, snapshot) {
                    if (snapshot.data == "") {
                      return Container();
                    }
                    if (snapshot.data != "") {
                      return Column(
                        children: [
                          OutlinedButton(
                              onPressed: () {
                                removePin();
                                setState(() {});
                              },
                              child: const Text("Removed saved M-Pin")),
                          const SizedBox(height: 30),
                        ],
                      );
                    }
                    return const CircularProgressIndicator();
                  })),
              //OutlinedButton(
              //         onPressed: () {
              //           removePin();
              //           setState(() {});
              //         },
              //         child: const Text("Removed saved M-Pin"))

              // const SizedBox(height: 30),
              Text(
                "Enter M-Pin",
                style: TextStyle(fontSize: 12.sp),
              ),
              // const TextWidget(
              //     label: "M-Pin",
              //     icon: Icons.onetwothree,
              //     textType: TextInputType.number,
              //     obscureTxt: false),

              Pinput(
                controller: mpin1,
                obscureText: true,
                onCompleted: ((value) => debugPrint(value)),
              ),
              const SizedBox(height: 10),
              Text(
                "Re-Enter M-Pin",
                style: TextStyle(fontSize: 12.sp),
              ),
              // const TextWidget(
              //     label: "M-Pin",
              //     icon: Icons.onetwothree,
              //     textType: TextInputType.number,
              //     obscureTxt: false),

              Pinput(
                controller: mpin2,
                obscureText: true,
                onCompleted: ((value) => debugPrint(value)),
                validator: (value) {
                  if (value == mpin1.text) {
                    return null;
                  } else {
                    mpin1.clear();
                    mpin2.clear();
                    return "Pin doesn't match";
                  }
                },
              ),
              // ElevatedButton(
              //   onPressed: () {},
              //   style: myButtonStyle(),
              //   child: Text(
              //     "Set M-Pin",
              //     style: myButtonTextStyle(),
              //   ),
              // ),
              const SizedBox(height: 10),
              MyButton(
                onPressFunc: () {
                  if (mpin1.text == mpin2.text && mpin1.text.isNotEmpty) {
                    debugPrint(mpin1.text);
                    setPin(mpin1.text);
                    debugPrint("MPin Stored");

                    mpin1.clear();
                    mpin2.clear();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Success"),
                          content: const Text(
                              "M-Pin success, Next login will require M-Pin."),
                          actions: [
                            MyButton(
                                onPressFunc: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text("Okay"))
                          ],
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Error"),
                          content: const Text(
                              "M Pins doesnt match, Please make sure both M Pins are same."),
                          actions: [
                            MyButton(
                                onPressFunc: () {
                                  Navigator.pop(context);
                                  mpin1.clear();
                                  mpin2.clear();
                                },
                                child: const Text("Re-Enter"))
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text("Set M-Pin", style: myButtonTextStyle()),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
