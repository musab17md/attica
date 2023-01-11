import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../screens/prod_detail.dart';
import '../ui_elements/colors.dart';
import '../ui_elements/constant.dart';

class CardImagesList extends StatelessWidget {
  const CardImagesList({super.key, required this.width, required this.id});
  final double width;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdDetail(id: id),
              ));
        },
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 15.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: kCardBackgroundColor,
          child: SizedBox(
            width: width / 2 - 24,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Image.asset(coinBarGoldItems[id][1]),
                ),
                const SizedBox(height: 0),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, bottom: 8, top: 2),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          coinBarGoldItems[id][2],
                          style: TextStyle(color: kText1, fontSize: 13.sp),
                        ),
                        Text(
                          "Diamond Necklace In 18Kt Gold with 23.27 gms with Diamonds 2.68 Ct, VS-GHI",
                          style: TextStyle(color: kText2, fontSize: 9.sp),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "\$ 300",
                          style: TextStyle(color: kText1, fontSize: 14.sp),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       "\$ 300",
                        //       style: TextStyle(color: kText1, fontSize: 14.sp),
                        //     ),
                        //     Card(
                        //       color: kButton,
                        //       child: const SizedBox(
                        //         width: 35,
                        //         height: 35,
                        //         child: Center(
                        //             child: Text(
                        //           "+",
                        //           style: TextStyle(fontSize: 26),
                        //         )),
                        //       ),
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
