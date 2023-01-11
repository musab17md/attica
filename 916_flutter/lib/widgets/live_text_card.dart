import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gold/ui_elements/constant.dart';
import 'package:sizer/sizer.dart';

import '../ui_elements/colors.dart';

List<Color> silverColors = [
  Colors.red,
  Colors.blue,
  Colors.white,
  Colors.red,
];
List<Color> goldColors = [
  Colors.red,
  Colors.yellow,
  Colors.orange,
  Colors.red,
];

class LiveTextCard3 extends StatelessWidget {
  const LiveTextCard3({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: kCardBackgroundColor,
          elevation: cardElevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Live Gold Rate",
                      style: TextStyle(fontSize: 7.sp),
                    ),
                    Text(
                      "5500.00",
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  ],
                ),
                const SizedBox(height: 40, child: VerticalDivider()),
                Column(
                  children: [
                    Text(
                      "Live Silver Rate",
                      style: TextStyle(fontSize: 7.sp),
                    ),
                    Text(
                      "1200.00",
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LiveTextCard extends StatelessWidget {
  const LiveTextCard(
      {super.key,
      required this.cardWidth,
      required this.text,
      required this.amount});
  final double cardWidth;
  final String text;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kCardBackgroundColor,
      child: SizedBox(
        width: cardWidth,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Text(
              //   "Live Gold Rate",
              //   style: TextStyle(color: Colors.white),
              // ),
              AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    text,
                    textStyle: const TextStyle(
                      fontSize: 18.0,
                    ),
                    colors: (text == "Live Silver Rate")
                        ? silverColors
                        : goldColors,
                  ),
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
              ),
              const Divider(
                color: Colors.black,
              ),
              Text(
                amount,
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LiveTextCard2 extends StatelessWidget {
  const LiveTextCard2(
      {super.key,
      required this.cardWidth,
      required this.text,
      required this.amount});
  final double cardWidth;
  final String text;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: cardElevation,
      color: kCardBackgroundColor,
      child: SizedBox(
        width: cardWidth,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Text(
              //   "Live Gold Rate",
              //   style: TextStyle(color: Colors.white),
              // ),
              Text(
                text,
                style: const TextStyle(color: kText1),
              ),
              const Divider(
                color: Colors.black,
              ),
              Text(
                amount,
                style: const TextStyle(color: kText1),
              )
            ],
          ),
        ),
      ),
    );
  }
}
