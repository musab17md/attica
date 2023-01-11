import 'package:flutter/material.dart';
import 'package:flutter_gold/ui_elements/constant.dart';
import 'package:sizer/sizer.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../ui_elements/colors.dart';

class BuySellTab2 extends StatefulWidget {
  const BuySellTab2({super.key, required this.isSell});
  final bool isSell;

  @override
  State<BuySellTab2> createState() => _BuySellTab2State();
}

class _BuySellTab2State extends State<BuySellTab2> {
  TextEditingController goldAmountController = TextEditingController();
  TextEditingController goldGramController = TextEditingController();
  TextEditingController silverAmountController = TextEditingController();
  TextEditingController silverGramController = TextEditingController();
  bool isGoldActive = true;
  final _razorpay = Razorpay();

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
  razorPayHandler() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  razorPayDispose() {
    _razorpay.clear();
    debugPrint("Cleared razorpay object with dispose method");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    razorPayDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: width / 2 - 80,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(12), // <-- Radius
                      // ),
                      shape: const StadiumBorder(),
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
                        color: isGoldActive ? kWhite : kBlack, fontSize: 14.sp),
                  )),
            ),
            SizedBox(
              width: width / 2 - 80,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(12), // <-- Radius
                      // ),
                      shape: const StadiumBorder(),
                      backgroundColor:
                          isGoldActive ? kSilverButton : kSilverButtonActive),
                  onPressed: () {
                    setState(() {
                      isGoldActive = false;
                    });
                  },
                  child: Text(
                    "Silver",
                    style: TextStyle(
                        color: isGoldActive ? kBlack : kWhite, fontSize: 14.sp),
                  )),
            ),
          ],
        ),
        isGoldActive
            ? BuySellContent(
                width: width,
                name: "My Gold Balance : 10.5gms",
                gram: goldGramController,
                metalAmount: goldAmountController,
                metalPrice: goldRate,
                active: "gold",
                isSell: widget.isSell,
              )
            : BuySellContent(
                width: width,
                name: "My Silver Balance : 50.5gms",
                gram: silverGramController,
                metalAmount: silverAmountController,
                metalPrice: silverRate,
                active: "silver",
                isSell: widget.isSell,
              ),
      ],
    );
  }
}

// class BuySellTab extends StatefulWidget {
//   const BuySellTab({super.key, required this.width});
//   final double width;

//   @override
//   State<BuySellTab> createState() => _BuySellTabState();
// }

// class _BuySellTabState extends State<BuySellTab> {
//   TextEditingController goldAmountController = TextEditingController();
//   TextEditingController goldGramController = TextEditingController();
//   TextEditingController silverAmountController = TextEditingController();
//   TextEditingController silverGramController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 270,
//       child: DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           body: Column(
//             children: [
//               TabBar(
//                 tabs: [
//                   designTab("Gold"),
//                   designTab("Silver"),
//                 ],
//                 labelColor: Colors.red,
//                 labelStyle:
//                     const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
//                 unselectedLabelColor: Colors.grey,
//                 indicatorColor: kBackgroundColor,
//                 indicatorSize: TabBarIndicatorSize.tab,
//                 labelPadding: const EdgeInsets.all(0),
//                 indicatorPadding: const EdgeInsets.all(0),
//                 splashFactory: NoSplash.splashFactory,
//                 overlayColor: MaterialStateProperty.resolveWith<Color?>(
//                     (Set<MaterialState> states) {
//                   return states.contains(MaterialState.focused)
//                       ? null
//                       : Colors.transparent;
//                 }),
//               ),
//               Card(
//                 elevation: cardElevation,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//                 color: kCardBackgroundColor,
//                 child: SizedBox(
//                   height: 200,
//                   child: TabBarView(
//                     children: [
//                       BuySellContent(
//                         width: widget.width,
//                         name: "My Gold Balance : 10.5gms",
//                         gram: goldGramController,
//                         metalAmount: goldAmountController,
//                         metalPrice: goldRate,
//                         active: '',
//                       ),
//                       BuySellContent(
//                         width: widget.width,
//                         name: "My Silver Balance : 50.5gms",
//                         gram: silverGramController,
//                         metalAmount: silverAmountController,
//                         metalPrice: silverRate,
//                         active: '',
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget designTab(String text) {
//     return Container(
//       height: 50 + MediaQuery.of(context).padding.bottom,
//       padding: const EdgeInsets.all(8),
//       width: double.infinity,
//       decoration: BoxDecoration(
//           color: kCardBackgroundColor,
//           border: Border.all(color: kBackgroundColor, width: 5),
//           borderRadius: BorderRadius.circular(12.0)),
//       child: Tab(
//         // child: Row(
//         //   mainAxisAlignment: MainAxisAlignment.center,
//         //   children: [
//         //     const Icon(
//         //       Icons.paid_outlined,
//         //       color: Colors.red,
//         //     ),
//         //     const SizedBox(width: 5),
//         //     Text(text),
//         //   ],
//         // ),
//         text: text,
//       ),
//     );
//   }
// }

class BuySellContent extends StatelessWidget {
  const BuySellContent(
      {super.key,
      required this.width,
      required this.name,
      required this.metalAmount,
      required this.gram,
      required this.metalPrice,
      required this.active,
      required this.isSell});
  final double width;
  final String name;
  final TextEditingController metalAmount;
  final TextEditingController gram;
  final int metalPrice;
  final String active;
  final bool isSell;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: kCardBackgroundColor,
      child: Column(
        children: [
          const SizedBox(height: 15),
          Text(
            name,
            style: TextStyle(color: kWhite, fontSize: 14.sp),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: width / 3,
                  height: 40,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: metalAmount,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 8.0),
                      labelText: 'Enter Amount',
                      labelStyle:
                          TextStyle(color: Colors.grey, fontSize: 10.sp),
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0.8, color: kBackgroundColor)),
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.white)),
                    ),
                    onChanged: (value) {
                      debugPrint(value.toString());
                      gram.text = ((double.tryParse(value) ?? 0) / metalPrice)
                          .toStringAsFixed(3);
                    },
                  ),
                ),
              ),
              const Icon(
                Icons.swap_horizontal_circle_sharp,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: width / 3,
                  height: 40,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: gram,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 8.0),
                      labelText: 'Enter Grams',
                      labelStyle:
                          TextStyle(color: Colors.grey, fontSize: 10.sp),
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0.8, color: kBackgroundColor)),
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.white)),
                    ),
                    onChanged: (value) {
                      debugPrint(value.toString());
                      metalAmount.text =
                          ((double.tryParse(value) ?? 0) * metalPrice)
                              .toStringAsFixed(2);
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: SizedBox(
              width: 180,
              child: isSell
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor:
                              (active == "gold") ? kGold : kSilver),
                      onPressed: () {},
                      child: Text(
                        "Sell",
                        style: TextStyle(
                            color: (active == "gold") ? kWhite : kWhite,
                            fontSize: 14.sp),
                      ),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor:
                              (active == "gold") ? kGold : kSilver),
                      onPressed: () {},
                      child: Text(
                        "Buy",
                        style: TextStyle(
                            color: (active == "gold") ? kWhite : kWhite,
                            fontSize: 14.sp),
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 15),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     ElevatedButton(
          //       style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
          //       onPressed: () {},
          //       child: const Text("Buy"),
          //     ),
          //     const SizedBox(
          //       height: 30,
          //       child: VerticalDivider(
          //         color: Colors.white,
          //         width: 15,
          //       ),
          //     ),
          //     ElevatedButton(
          //       style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          //       onPressed: () {},
          //       child: const Text("Sell"),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
