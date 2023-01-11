import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../ui_elements/colors.dart';
import '../ui_elements/constant.dart';
import '../widgets/app_bar.dart';

class WithdrawAmount extends StatefulWidget {
  const WithdrawAmount({super.key});

  @override
  State<WithdrawAmount> createState() => _WithdrawAmountState();
}

class _WithdrawAmountState extends State<WithdrawAmount> {
  bool isUpiActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: const MyAppBar2(
        title: "Withdraw Wallet",
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
                  "Withdraw Wallet",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: kButton),
                        onPressed: () {
                          isUpiActive = true;
                          setState(() {});
                        },
                        child: Text(
                          "@-UPI",
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: kButtonText,
                          ),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: kButton),
                        onPressed: () {
                          isUpiActive = false;
                          setState(() {});
                        },
                        child: Text(
                          "Bank Transfer",
                          style: TextStyle(fontSize: 11.sp, color: kButtonText),
                        )),
                  ],
                ),
                isUpiActive ? const UpiWidget() : const BankWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UpiWidget extends StatelessWidget {
  const UpiWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
            labelText: 'Enter UPI ID',
            labelStyle: TextStyle(color: Colors.grey, fontSize: 10.sp),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 0.8, color: kBackgroundColor)),
            border: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.white)),
          ),
          onChanged: (value) {},
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(), backgroundColor: kButton),
            onPressed: () {},
            child: Text(
              "Proceed to withdraw",
              style: TextStyle(
                fontSize: 11.sp,
                color: kButtonText,
              ),
            )),
      ],
    );
  }
}

class BankWidget extends StatelessWidget {
  const BankWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
            labelText: 'Enter Account holder name',
            labelStyle: TextStyle(color: Colors.grey, fontSize: 10.sp),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 0.8, color: kBackgroundColor)),
            border: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.white)),
          ),
          onChanged: (value) {},
        ),
        TextField(
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
            labelText: 'Enter Account Number',
            labelStyle: TextStyle(color: Colors.grey, fontSize: 10.sp),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 0.8, color: kBackgroundColor)),
            border: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.white)),
          ),
          onChanged: (value) {},
        ),
        TextField(
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
            labelText: 'Enter Account Type',
            labelStyle: TextStyle(color: Colors.grey, fontSize: 10.sp),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 0.8, color: kBackgroundColor)),
            border: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.white)),
          ),
          onChanged: (value) {},
        ),
        TextField(
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
            labelText: 'Enter IFSC Code',
            labelStyle: TextStyle(color: Colors.grey, fontSize: 10.sp),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 0.8, color: kBackgroundColor)),
            border: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.white)),
          ),
          onChanged: (value) {},
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(), backgroundColor: kButton),
            onPressed: () {},
            child: Text(
              "Proceed to withdraw",
              style: TextStyle(fontSize: 11.sp),
            )),
      ],
    );
  }
}
