import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gold/ui_elements/colors.dart';
import 'package:sizer/sizer.dart';

import '../ui_elements/constant.dart';

class BestOffers extends StatelessWidget {
  const BestOffers({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Best Offers",
                style: TextStyle(color: kText1, fontSize: 17.sp),
              ),
              Text(
                "View all",
                style: TextStyle(color: kGold, fontSize: 12.sp),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
          child: SizedBox(
            width: width / 2,
            child: Text(
              "Choose from 10000+ trendy, lightweight and affordable designer pieces!",
              style: TextStyle(color: kText2, fontSize: 9.sp),
            ),
          ),
        ),
        const BestOfferCarousel(),
      ],
    );
  }
}

class BestOfferCarousel extends StatelessWidget {
  const BestOfferCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      width: double.infinity,
      child: CarouselSlider(
        options: CarouselOptions(
          height: 200,
          viewportFraction: 0.5,
          initialPage: 0,
          enableInfiniteScroll: false,
          reverse: false,
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          scrollDirection: Axis.horizontal,
        ),
        items: coinBarGoldItems.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return const CarouselItem();
            },
          );
        }).toList(),
      ),
    );
  }
}

class CarouselItem extends StatelessWidget {
  const CarouselItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Wrap(
        children: [
          SizedBox(
            width: 130,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                child: Image.asset("assets/image/necklace2.jpg")),
          ),
          Text(
            "Beau Tie Necklace",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.sp),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "\$14,790",
                style: TextStyle(fontSize: 11.sp),
              ),
              Text(
                "\$21,872",
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
          Text(
            "100% Off on Making Charges",
            style: TextStyle(fontSize: 7.5.sp, color: kText2),
          ),
        ],
      ),
    );
  }
}
