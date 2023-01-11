import 'package:flutter/material.dart';

import '../ui_elements/colors.dart';
import '../ui_elements/constant.dart';
import '../widgets/card_image_view.dart';
import '../widgets/catg_scroll.dart';

class JewelleryPage extends StatefulWidget {
  const JewelleryPage({super.key});

  @override
  State<JewelleryPage> createState() => _JewelleryPageState();
}

class _JewelleryPageState extends State<JewelleryPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
              ),
              context: context,
              builder: ((context) {
                return SizedBox(
                  height: 250.0,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: kCardBackgroundColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Filter By",
                                style: TextStyle(color: kText2),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.close)),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Price low to high",
                            style: TextStyle(fontSize: 22),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Price high to low",
                            style: TextStyle(fontSize: 22),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Popular Items",
                            style: TextStyle(fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }));
        },
        child: const Icon(Icons.filter_alt_outlined),
      ),
      body: Column(
        children: [
          const CatgScroll2(),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                direction: Axis.horizontal,
                children: [
                  for (var i in coinBarGoldItems)
                    CardImagesList(
                      width: width,
                      id: int.parse(i[0]),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
