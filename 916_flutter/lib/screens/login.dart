import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gold/main.dart';
import 'package:flutter_gold/screens/sign_up.dart';
import 'package:flutter_gold/ui_elements/constant.dart';
import 'package:flutter_gold/ui_elements/widget_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../ui_elements/colors.dart';
import '../widgets/textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController numberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool isOtpSent = false;
  int codeNumber = 000000;

  saveLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    // prefs.setBool("isloggedin", true);
    prefs.setStringList("credentials", [numberController.text, '']);
  }

  sendOtp() {
    if (numberController.text.length == 10) {
      if (int.tryParse(numberController.text) == null) {
        showErrorDialog("Incorrect number format");
      } else {
        // API Call > check if Number is registered
        bool apiCall = true;
        if (apiCall) {
          debugPrint(numberController.text);
          Random random = Random();
          codeNumber = random.nextInt(900000) + 100000;
          debugPrint(codeNumber.toString());
          setState(() {
            isOtpSent = true;
          });
        } else {
          showErrorDialog("Number is not registered! Please Sign Up.");
        }
      }
    } else {
      showErrorDialog("Required 10 digits mobile number.");
    }
  }

  loginNow() {
    if (otpController.text == codeNumber.toString()) {
      debugPrint("Otp Matched");
      saveLoginStatus();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHomePage(),
          ),
          (route) => false);
    } else {
      showErrorDialog("You have entered incorrect otp! Try again.");
    }
  }

  showErrorDialog(text) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: kCardBackgroundColor,
          title: const Text("Error"),
          content: Text(text),
          actions: [
            MyButton(
                onPressFunc: () {
                  Navigator.pop(context);
                },
                child: const Text("Okay"))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            const LoginTopDesign(),
            (isOtpSent)
                ? ShowOtpLogin(
                    otpController: otpController,
                    loginNow: loginNow,
                    otp: codeNumber.toString(),
                  )
                : ShowMobileLogin(
                    numberController: numberController,
                    sendOtp: sendOtp,
                  ),
          ],
        ),
      ),
    );
  }
}

class ShowOtpLogin extends StatefulWidget {
  const ShowOtpLogin(
      {super.key,
      required this.otpController,
      required this.loginNow,
      required this.otp});
  final TextEditingController otpController;
  final Function loginNow;
  final String otp;

  @override
  State<ShowOtpLogin> createState() => _ShowOtpLoginState();
}

class _ShowOtpLoginState extends State<ShowOtpLogin> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "OTP is sent to\nyour number!",
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
            Text(widget.otp),
            const SizedBox(height: 30),
            TextWidget(
              label: 'OTP Number',
              icon: Icons.phone_iphone,
              textType: TextInputType.number,
              obscureTxt: false,
              textControl: widget.otpController,
            ),
            const SizedBox(height: 30),
            Center(
              child: GestureDetector(
                onTap: () {
                  widget.loginNow();
                },
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: const BoxDecoration(
                      color: kGold,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: Icon(
                    Icons.arrow_right_alt_sharp,
                    size: 25.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShowMobileLogin extends StatefulWidget {
  const ShowMobileLogin(
      {super.key, required this.numberController, required this.sendOtp});
  final TextEditingController numberController;
  final Function sendOtp;

  @override
  State<ShowMobileLogin> createState() => _ShowMobileLoginState();
}

class _ShowMobileLoginState extends State<ShowMobileLogin> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Welcome\nBack!",
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
            const SizedBox(height: 30),
            TextWidget(
              label: 'Mobile Number',
              icon: Icons.phone_iphone,
              textType: TextInputType.number,
              obscureTxt: false,
              textControl: widget.numberController,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupPage(),
                      )),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.sendOtp();
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: const BoxDecoration(
                        color: kGold,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Icon(
                      Icons.arrow_right_alt_sharp,
                      size: 25.sp,
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

class LoginTopDesign extends StatelessWidget {
  const LoginTopDesign({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int wAdd = 100;
    return SizedBox(
      width: double.infinity,
      child: Stack(children: [
        Positioned(
          left: -150,
          top: -350,
          child: Container(
            width: width + wAdd,
            height: width + wAdd,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(width + wAdd)),
              color: kGold,
            ),
          ),
        ),
        Positioned(
          top: 50,
          right: 50,
          child: SizedBox(
            height: 100,
            width: 100,
            child: Image.asset("assets/image/logo.png"),
          ),
        ),
      ]),
    );
  }
}

class LoginPage3 extends StatefulWidget {
  const LoginPage3({super.key});

  @override
  State<LoginPage3> createState() => _LoginPage3State();
}

class _LoginPage3State extends State<LoginPage3> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController numberController = TextEditingController();
  bool isOtpSent = false;

  saveCred() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('credentials',
        <String>[usernameController.text, passwordController.text, '']);
  }

  loginNow() {
    debugPrint(usernameController.text);
    debugPrint(passwordController.text);
    if (usernameController.text == credentials[0] &&
        passwordController.text == credentials[1]) {
      showDialog(
        context: context,
        builder: (context) {
          return const Card(
            color: kCardBackgroundColor,
            child: Text("Logging you in. . ."),
          );
        },
      );
      debugPrint("user pass matched!");
      saveCred();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHomePage(),
          ),
          (route) => false);
    } else {
      debugPrint("Incorrect user or pass");
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: kCardBackgroundColor,
            title: const Text("Error"),
            content: const Text("Incorrect username or password."),
            actions: [
              MyButton(
                  onPressFunc: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Okay"))
            ],
          );
        },
      );
    }
  }

  sendOtp() {
    if (numberController.text.length == 10) {
      debugPrint("10 digits");
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int wAdd = 100;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              left: -150,
              top: -350,
              child: Container(
                width: width + wAdd,
                height: width + wAdd,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(width + wAdd)),
                  color: kGold,
                ),
              ),
            ),
            Positioned(
              top: 50,
              right: 50,
              child: SizedBox(
                height: 100,
                width: 100,
                child: Image.asset("assets/image/logo.png"),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: isOtpSent
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "OTP is sent to\nyour number!",
                              style: TextStyle(fontSize: 20.sp),
                            ),
                          ),
                          const SizedBox(height: 30),
                          TextWidget(
                            label: 'Mobile Number',
                            icon: Icons.phone_iphone,
                            textType: TextInputType.number,
                            obscureTxt: false,
                            textControl: numberController,
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignupPage(),
                                    )),
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // loginNow();
                                  sendOtp();
                                },
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      color: kGold,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: Icon(
                                    Icons.arrow_right_alt_sharp,
                                    size: 25.sp,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Welcome\nBack!",
                              style: TextStyle(fontSize: 20.sp),
                            ),
                          ),
                          const SizedBox(height: 30),
                          TextWidget(
                            label: 'Mobile Number',
                            icon: Icons.phone_iphone,
                            textType: TextInputType.number,
                            obscureTxt: false,
                            textControl: usernameController,
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignupPage(),
                                    )),
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  loginNow();
                                },
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      color: kGold,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: Icon(
                                    Icons.arrow_right_alt_sharp,
                                    size: 25.sp,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage2 extends StatefulWidget {
  const LoginPage2({super.key});

  @override
  State<LoginPage2> createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  saveCred() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('credentials',
        <String>[usernameController.text, passwordController.text, '']);
  }

  loginNow() {
    debugPrint(usernameController.text);
    debugPrint(passwordController.text);
    if (usernameController.text == credentials[0] &&
        passwordController.text == credentials[1]) {
      showDialog(
        context: context,
        builder: (context) {
          return const Card(
            color: kCardBackgroundColor,
            child: Text("Logging you in. . ."),
          );
        },
      );
      debugPrint("user pass matched!");
      saveCred();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHomePage(),
          ),
          (route) => false);
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => const MyHomePage(),
      //     ));
    } else {
      debugPrint("Incorrect user or pass");
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: kCardBackgroundColor,
            title: const Text("Error"),
            content: const Text("Incorrect username or password."),
            actions: [
              MyButton(
                  onPressFunc: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Okay"))
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int wAdd = 100;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              left: -150,
              top: -350,
              child: Container(
                width: width + wAdd,
                height: width + wAdd,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(width + wAdd)),
                  color: kGold,
                ),
              ),
            ),
            Positioned(
              top: 50,
              right: 50,
              child: SizedBox(
                height: 100,
                width: 100,
                child: Image.asset("assets/image/logo.png"),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Welcome\nBack!",
                        style: TextStyle(fontSize: 20.sp),
                      ),
                    ),
                    TextWidget(
                      label: 'Username',
                      icon: Icons.person,
                      textType: TextInputType.name,
                      obscureTxt: false,
                      textControl: usernameController,
                    ),
                    const SizedBox(height: 30),
                    TextWidget(
                      label: 'Password',
                      icon: Icons.key,
                      textType: TextInputType.visiblePassword,
                      obscureTxt: true,
                      textControl: passwordController,
                    ),
                    const SizedBox(height: 30),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Forgot password?",
                        textAlign: TextAlign.right,
                        style: TextStyle(color: kGold),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignupPage(),
                              )),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            loginNow();
                          },
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: const BoxDecoration(
                                color: kGold,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: Icon(
                              Icons.arrow_right_alt_sharp,
                              size: 25.sp,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
