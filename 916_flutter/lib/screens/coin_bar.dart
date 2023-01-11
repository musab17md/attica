import 'package:flutter/material.dart';
import 'package:flutter_gold/ui_elements/colors.dart';
import 'package:flutter_gold/ui_elements/constant.dart';
import 'package:sizer/sizer.dart';

import '../widgets/card_image_view.dart';

class CoinBarPage extends StatefulWidget {
  const CoinBarPage({super.key});

  @override
  State<CoinBarPage> createState() => _CoinBarPageState();
}

class _CoinBarPageState extends State<CoinBarPage> {
  String dropdownValue = categories.first;
  bool isGoldActive = true;

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
          // showDialog(
          //   context: context,
          //   builder: (context) {
          //     return const Scaffold(
          //       backgroundColor: Colors.transparent,
          //       body: BottomSheet(onClosing: onClosing, builder: builder),
          //     );
          //   },
          // );
        },
        child: const Icon(Icons.filter_alt_outlined),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: width / 2 - 10,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isGoldActive ? kGoldButtonActive : kGoldButton),
                    onPressed: () {
                      setState(() {
                        isGoldActive = true;
                      });
                    },
                    child: Text(
                      "Gold",
                      style: TextStyle(
                          color: isGoldActive ? kWhite : kBlack,
                          fontSize: 11.sp),
                    )),
              ),
              SizedBox(
                width: width / 2 - 10,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isGoldActive ? kSilverButton : kSilverButtonActive),
                    onPressed: () {
                      setState(() {
                        isGoldActive = false;
                      });
                    },
                    child: Text(
                      "Silver",
                      style: TextStyle(color: isGoldActive ? kBlack : kWhite),
                    )),
              ),
            ],
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Row(
          //     children: [
          //       const Text("Categories"),
          //       const SizedBox(width: 10),
          //       DropdownButton<String>(
          //         value: dropdownValue,
          //         icon: const Icon(Icons.arrow_downward),
          //         elevation: 16,
          //         style: const TextStyle(color: Colors.deepPurple),
          //         underline: Container(
          //           height: 2,
          //           color: Colors.deepPurpleAccent,
          //         ),
          //         onChanged: (String? value) {
          //           setState(() {
          //             dropdownValue = value!;
          //           });
          //         },
          //         items: categories.map<DropdownMenuItem<String>>((String value) {
          //           return DropdownMenuItem<String>(
          //             value: value,
          //             child: Text(value),
          //           );
          //         }).toList(),
          //       ),
          //       const Spacer(),
          //       OutlinedButton(
          //           onPressed: () {},
          //           child: Row(
          //             children: const [
          //               Icon(Icons.filter_alt_outlined),
          //               Text("Filter")
          //             ],
          //           )),
          //     ],
          //   ),
          // ),
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
