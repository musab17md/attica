import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'colors.dart';

myButtonStyle() {
  return ElevatedButton.styleFrom(
      shape: const StadiumBorder(), backgroundColor: kButton);
}

myButtonTextStyle() {
  return TextStyle(color: kWhite, fontSize: 14.sp);
}

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.onPressFunc, required this.child});
  final Function() onPressFunc;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressFunc,
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: kGold,
      ),
      child: child,
    );
  }
}
