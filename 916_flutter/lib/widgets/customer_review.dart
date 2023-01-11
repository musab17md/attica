import 'package:flutter/material.dart';
import 'package:flutter_gold/ui_elements/colors.dart';
import 'package:sizer/sizer.dart';

class CustomerReview extends StatelessWidget {
  const CustomerReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            "What our customers say",
            style: TextStyle(color: kText1, fontSize: 17.sp),
          ),
        ),
        SizedBox(
          height: 230,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              commentBox(),
              commentBox(),
              commentBox(),
              commentBox(),
            ],
          ),
        ),
      ],
    );
  }

  Widget commentBox() {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0, bottom: 25, left: 8, right: 8),
          child: SizedBox(
            width: 300,
            child: Card(
              elevation: 8.0,
              color: kCardBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Icon(
                          Icons.format_quote_rounded,
                          size: 33,
                          color: kText2,
                        ),
                        Text(
                          "I have a great experience in 916 Digital as they have stunning customer support with the brilliant design team. Over all 916 Digital will reach its apex of fave very soon",
                          style: TextStyle(fontSize: 10.5.sp),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Row(
                        children: [
                          Text(
                            "Tony Stark",
                            style: TextStyle(fontSize: 10.5.sp),
                          ),
                          const SizedBox(height: 20, child: VerticalDivider()),
                          Text(
                            "You Matter gold finger ring",
                            style: TextStyle(color: kGold, fontSize: 10.5.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Container(
            width: 55,
            height: 55,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(blurRadius: 5.0, offset: Offset(0.0, 0.75))
              ],
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/image/necklace.jpg"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
