import 'package:flutter/material.dart';
import 'package:flutter_gold/main.dart';
import 'package:flutter_gold/ui_elements/colors.dart';
import 'package:pinput/pinput.dart';

class EnterMpin extends StatefulWidget {
  const EnterMpin({super.key, required this.pin});
  final String pin;

  @override
  State<EnterMpin> createState() => _EnterMpinState();
}

class _EnterMpinState extends State<EnterMpin> {
  TextEditingController mpin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Enter M-Pin"),
            Pinput(
              controller: mpin,
              obscureText: true,
              onCompleted: ((value) => debugPrint(value)),
              validator: (value) {
                if (value == widget.pin) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyHomePage(),
                      ),
                      (route) => false);
                } else {
                  mpin.clear();
                  return "Pin doesn't match";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
