import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../ui_elements/colors.dart';
import '../widgets/textfield.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();

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
                        "Register!",
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
                    const SizedBox(height: 15),
                    TextWidget(
                      label: 'Mobile Number',
                      icon: Icons.phone_iphone,
                      textType: TextInputType.number,
                      obscureTxt: false,
                      textControl: mobileController,
                    ),
                    const SizedBox(height: 15),
                    TextWidget(
                      label: 'Email',
                      icon: Icons.mail,
                      textType: TextInputType.emailAddress,
                      obscureTxt: false,
                      textControl: emailController,
                    ),
                    const SizedBox(height: 15),
                    TextWidget(
                      label: 'Password',
                      icon: Icons.key,
                      textType: TextInputType.visiblePassword,
                      obscureTxt: true,
                      textControl: passwordController,
                    ),
                    const SizedBox(height: 15),
                    TextWidget(
                      label: 'Re-Enter Password',
                      icon: Icons.key,
                      textType: TextInputType.visiblePassword,
                      obscureTxt: true,
                      textControl: repasswordController,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: const BoxDecoration(
                                color: kGold,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_back_ios_outlined,
                                  size: 10.sp,
                                ),
                                const Text("Login   "),
                              ],
                            ),
                          ),
                        ),
                        Container(
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
