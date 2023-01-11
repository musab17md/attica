import 'package:flutter/material.dart';
import 'package:flutter_gold/ui_elements/colors.dart';
import 'package:flutter_gold/ui_elements/constant.dart';

class CatgScroll extends StatelessWidget {
  const CatgScroll({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryItems.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 11.0),
            child: Column(
              children: [
                Image.asset(
                  categoryItems[index][1],
                  height: 60,
                ),
                Text(
                  categoryItems[index][0],
                  style: const TextStyle(color: kText1),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CatgScroll2 extends StatefulWidget {
  const CatgScroll2({super.key});

  @override
  State<CatgScroll2> createState() => _CatgScroll2State();
}

class _CatgScroll2State extends State<CatgScroll2> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryItems.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  activeIndex = index;
                });
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: (activeIndex == index) ? kButtonActive : kButtonInActive,
                elevation: 8.0,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Text(
                      categoryItems[index][0],
                      style: TextStyle(
                          color: (activeIndex == index)
                              ? kButtonTextActive
                              : kButtonTextInActive),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
