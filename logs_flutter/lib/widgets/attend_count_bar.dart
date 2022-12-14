import 'package:flutter/material.dart';

class AttendCountBar extends StatelessWidget {
  const AttendCountBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: const [
                  Text("200",
                      style: TextStyle(color: Colors.white, fontSize: 26)),
                  Text("Total",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
            ),
            const VerticalDivider(
              thickness: 1,
              indent: 5,
              endIndent: 5,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: const [
                  Text("180",
                      style: TextStyle(color: Colors.white, fontSize: 26)),
                  Text("Attended",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
            ),
            const VerticalDivider(
              thickness: 1,
              indent: 5,
              endIndent: 5,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: const [
                  Text("20",
                      style: TextStyle(color: Colors.white, fontSize: 26)),
                  Text("Skipped",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
