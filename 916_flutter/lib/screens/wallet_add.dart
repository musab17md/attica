import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../ui_elements/colors.dart';
import '../ui_elements/constant.dart';
import '../widgets/app_bar.dart';

class AddAmount extends StatelessWidget {
  const AddAmount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: const MyAppBar2(
        title: "Wallet Topup",
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: cardElevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: kCardBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Topup Wallet",
                  style: TextStyle(fontSize: 14.sp),
                ),
                const SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 8.0),
                    labelText: 'Enter Amount',
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 10.sp),
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0.8, color: kBackgroundColor)),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.white)),
                  ),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        "1000",
                        style: TextStyle(fontSize: 10.sp, color: kText1),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        "2000",
                        style: TextStyle(fontSize: 10.sp, color: kText1),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        "5000",
                        style: TextStyle(fontSize: 10.sp, color: kText1),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        "10000",
                        style: TextStyle(fontSize: 10.sp, color: kText1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(), backgroundColor: kButton),
                    onPressed: () {},
                    child: Text(
                      "Proceed To Topup",
                      style: TextStyle(fontSize: 11.sp, color: kButtonText),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
