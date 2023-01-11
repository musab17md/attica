import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../ui_elements/colors.dart';

class ChoicePills extends StatelessWidget {
  const ChoicePills({super.key, required this.text, required this.selected});
  final String text;
  final String selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 5.0,
                  offset: Offset(0.0, 0.75))
            ],
            color: selected == text ? kButtonActive : kButtonInActive,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 10.sp,
                color:
                    selected == text ? kButtonTextActive : kButtonTextInActive),
          ),
        ),
      ),
    );
  }
}
