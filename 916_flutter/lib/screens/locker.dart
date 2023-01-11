import 'package:flutter/material.dart';
import 'package:flutter_gold/screens/enter_mpin.dart';
import 'package:flutter_gold/screens/locker_buy.dart';
import 'package:flutter_gold/screens/locker_sell.dart';
import 'package:flutter_gold/screens/login.dart';
import 'package:flutter_gold/screens/wallet_add.dart';
import 'package:flutter_gold/screens/wallet_withdraw.dart';
import 'package:provider/provider.dart';

import '../ui_elements/colors.dart';
import '../ui_elements/constant.dart';
import '../ui_elements/my_provider.dart';

class MyLocker extends StatefulWidget {
  const MyLocker({super.key});

  @override
  State<MyLocker> createState() => _MyLockerState();
}

class _MyLockerState extends State<MyLocker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: 100,
              child: Card(
                elevation: cardElevation,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: kCardBackgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Wallet Balance",
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      "\$ 0.00",
                      style: TextStyle(fontSize: 22),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kButton,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddAmount()));
                  },
                  child: const Text(
                    "Add Amount",
                    style: TextStyle(color: kButtonText),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kButton,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WithdrawAmount()));
                  },
                  child: const Text(
                    "Withdraw Amount",
                    style: TextStyle(color: kButtonText),
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: 100,
              child: Card(
                elevation: cardElevation,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: kCardBackgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Gold Balance : ",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          " 0.018 grm (\$ 110.00)",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Silver Balance : ",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          " 3.018 grm (\$ 10.00)",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kButton,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LockerBuy()));
                  },
                  child: const Text(
                    "Buy",
                    style: TextStyle(color: kButtonText),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kButton,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LockerSell()));
                  },
                  child: const Text(
                    "Sell",
                    style: TextStyle(color: kButtonText),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kButton,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    context.read<MyProvider>().pageIndex(1);
                  },
                  child: const Text(
                    "Delivery",
                    style: TextStyle(color: kButtonText),
                  )),
            ],
          ),
          OutlinedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: const Text("Login page")),
          OutlinedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EnterMpin(pin: "123")));
              },
              child: const Text("Mpin Page")),
        ],
      ),
    );
  }
}
