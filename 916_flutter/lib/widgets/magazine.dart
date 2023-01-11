import 'package:flutter/material.dart';

class Magazine extends StatelessWidget {
  const Magazine({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          magImage("assets/magazine/economictimes.png"),
          magImage("assets/magazine/elle.png"),
          magImage("assets/magazine/entrepreneur.jpg"),
          magImage("assets/magazine/livemint.png"),
          magImage("assets/magazine/theweek.png"),
        ],
      ),
    );
  }

  Widget magImage(link) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(link),
    );
  }
}
