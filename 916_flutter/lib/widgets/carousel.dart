import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../ui_elements/constant.dart';

class MyCarousel extends StatelessWidget {
  const MyCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 190.0,
        aspectRatio: 2.0,
        viewportFraction: 1.1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: false,
        enlargeFactor: 0.0,
        scrollDirection: Axis.horizontal,
      ),
      items: banners.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: const BoxDecoration(color: Colors.brown),
              child: Image.asset(i, fit: BoxFit.fill),
            );
          },
        );
      }).toList(),
    );
  }
}
