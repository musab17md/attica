import 'package:flutter/material.dart';

class ScrollCard extends StatelessWidget {
  const ScrollCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          ScrollCardView(),
          ScrollCardView(),
          ScrollCardView(),
          ScrollCardView(),
        ],
      ),
    );
  }
}

class ScrollCardView extends StatelessWidget {
  const ScrollCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SizedBox(
        width: 150,
        child: Stack(
          children: [
            SizedBox(
              // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
              height: 200,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: Image.asset(
                  "assets/background7.jpg",
                  fit: BoxFit.cover,
                  color: const Color.fromARGB(255, 43, 35, 33),
                  colorBlendMode: BlendMode.darken,
                  scale: 0.8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
