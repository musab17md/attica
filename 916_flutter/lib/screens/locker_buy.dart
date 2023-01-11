import 'package:flutter/material.dart';
import 'package:flutter_gold/widgets/buy_sell_tab.dart';
import 'package:sizer/sizer.dart';

import '../ui_elements/colors.dart';
import '../widgets/app_bar.dart';

class LockerBuy extends StatelessWidget {
  const LockerBuy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: const MyAppBar2(
        title: "Buy Digital Gold",
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Text(
              "Sell Digital Gold/Silver",
              style: TextStyle(fontSize: 14.sp),
            ),
            const SizedBox(height: 10),
            const BuySellTab2(isSell: false),
          ],
        ),
      ),
    );
  }
}
