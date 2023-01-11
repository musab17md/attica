import 'package:flutter/material.dart';
import 'package:flutter_gold/screens/login.dart';
import 'package:flutter_gold/screens/my_acc_pages/address.dart';
import 'package:flutter_gold/screens/my_acc_pages/edit_profile.dart';
import 'package:flutter_gold/screens/my_acc_pages/help_support.dart';
import 'package:flutter_gold/screens/my_acc_pages/kyc.dart';
import 'package:flutter_gold/screens/my_acc_pages/measurements.dart';
import 'package:flutter_gold/screens/my_acc_pages/my_orders.dart';
import 'package:flutter_gold/screens/my_acc_pages/privacy_policy.dart';
import 'package:flutter_gold/screens/my_acc_pages/set_pin.dart';
import 'package:flutter_gold/screens/my_acc_pages/terms.dart';
import 'package:flutter_gold/screens/my_acc_pages/wish_list.dart';
import 'package:flutter_gold/ui_elements/functions.dart';

import '../ui_elements/colors.dart';
import '../ui_elements/constant.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: const [
              Icon(
                Icons.person,
                size: 100,
              ),
              Text("Steve Rogers"),
              SizedBox(height: 10),
              AccOption(
                icon: Icon(Icons.edit),
                text: "Edit Profile",
                navigate: EditProfile(),
              ),
              AccOption(
                icon: Icon(Icons.favorite_outlined),
                text: "Wish List",
                navigate: WishList(),
              ),
              AccOption(
                icon: Icon(Icons.verified_user_outlined),
                text: "KYC",
                navigate: KycPage(),
              ),
              AccOption(
                icon: Icon(Icons.onetwothree),
                text: "Set M-Pin",
                navigate: SetPin(),
              ),
              AccOption(
                icon: Icon(Icons.straighten_rounded),
                text: "Measurements",
                navigate: MyMeasurments(),
              ),
              AccOption(
                icon: Icon(Icons.location_on_outlined),
                text: "My Address",
                navigate: MyAddress(),
              ),
              AccOption(
                icon: Icon(Icons.help_center_outlined),
                text: "Help and Support",
                navigate: HelpSupport(),
              ),
              AccOption(
                icon: Icon(Icons.list_alt),
                text: "My Orders",
                navigate: MyOrders(),
              ),
              AccOption(
                icon: Icon(Icons.security),
                text: "Privacy Policy",
                navigate: PrivacyPolicy(),
              ),
              AccOption(
                icon: Icon(Icons.assignment_outlined),
                text: "Terms and Conditions",
                navigate: TermsCondition(),
              ),
              AccOption(
                icon: Icon(Icons.logout_rounded),
                text: "Log Out",
                navigate: logout,
                funcName: "logout",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AccOption extends StatelessWidget {
  const AccOption(
      {super.key,
      required this.icon,
      required this.text,
      required this.navigate,
      this.funcName});
  final Icon icon;
  final String text;
  final dynamic navigate;
  final String? funcName;

  funcCall(context) {
    if (funcName == "logout") {
      navigate();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: GestureDetector(
        onTap: () => (funcName != null)
            ? funcCall(context)
            : Navigator.push(
                context, MaterialPageRoute(builder: (context) => navigate)),
        child: Card(
          elevation: cardElevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: kCardBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(width: 60, child: icon),
                Text(text),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
