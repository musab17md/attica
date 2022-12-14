import 'package:flutter/material.dart';

import '../ui_elements.dart/constants.dart';

DateTime now = DateTime.now();

class DateWidget extends StatelessWidget {
  const DateWidget({super.key});

  String getsuperscript(int n) {
    if (n == 1 || n == 21) {
      return 'st';
    } else if (n == 2 || n == 22) {
      return 'nd';
    } else if (n == 3 || n == 23) {
      return 'rd';
    } else {
      return 'th';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // "Sunday",
            weekdays[now.weekday],
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                now.day.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 28),
              ),
              Text(
                getsuperscript(now.day),
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 2),
                child: Text(
                  "${months[now.month]} ${now.year}",
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
