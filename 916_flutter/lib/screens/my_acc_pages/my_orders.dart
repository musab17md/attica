import 'package:flutter/material.dart';
import 'package:flutter_gold/ui_elements/constant.dart';
import 'package:sizer/sizer.dart';

import '../../ui_elements/colors.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/choice_pills.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  List options = [
    "Digital Gold",
    "Digital Silver",
    "Wallet Transaction",
    "Jewellery"
  ];
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: const MyAppBar2(
        title: "My Orders",
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 35.sp,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    onTap: () {
                      selected = 0;
                      setState(() {});
                    },
                    child: ChoicePills(
                      text: options[0],
                      selected: options[selected],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selected = 1;
                      setState(() {});
                    },
                    child: ChoicePills(
                      text: options[1],
                      selected: options[selected],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selected = 2;
                      setState(() {});
                    },
                    child: ChoicePills(
                      text: options[2],
                      selected: options[selected],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selected = 3;
                      setState(() {});
                    },
                    child: ChoicePills(
                      text: options[3],
                      selected: options[selected],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: const [
                  TransactItems(),
                  TransactItems(),
                  TransactItems(),
                  TransactItems(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactItems extends StatelessWidget {
  const TransactItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kCardBackgroundColor,
      elevation: cardElevation,
      child: const ListTile(
        leading: Icon(Icons.history_toggle_off_sharp),
        title: Text("Gold"),
        subtitle: Text("2022-12-22"),
        trailing: Text("10.854 gram"),
      ),
    );
  }
}
