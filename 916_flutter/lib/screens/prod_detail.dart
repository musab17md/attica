import 'package:flutter/material.dart';
import 'package:flutter_gold/ui_elements/colors.dart';
import 'package:flutter_gold/ui_elements/constant.dart';
import 'package:flutter_gold/widgets/app_bar.dart';

class ProdDetail extends StatelessWidget {
  const ProdDetail({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: MyAppBar2(
        title: "Product View #$id",
      ),
      bottomNavigationBar: Container(
          decoration: const BoxDecoration(color: kCardBackgroundColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: width / 3,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kButtonActive),
                    onPressed: () {},
                    child: const Text(
                      "Add to cart",
                      style: TextStyle(color: kButtonText),
                    )),
              ),
              SizedBox(
                width: width / 3,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kButtonActive),
                    onPressed: () {},
                    child: const Text(
                      "Buy Now",
                      style: TextStyle(color: kButtonText),
                    )),
              ),
            ],
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.asset(
                  coinBarGoldItems[id][1],
                  scale: 1,
                ),
              ),
            ),
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0)),
              ),
              color: kCardBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "₹4950",
                          style: TextStyle(fontSize: 22),
                        ),
                        Text("weight 10 gram"),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "(Based on latest gold price)",
                      style: TextStyle(color: kLightGreen, fontSize: 10),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: const [
                            Text(
                              "Product Id",
                              style: TextStyle(color: kGold),
                            ),
                            Text("171"),
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          height: 50,
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Colors.brown,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(color: kButton),
                                  width: 130 / 3 - 3,
                                  height: double.infinity,
                                  child: const Center(
                                    child: Text(
                                      "-",
                                      style: TextStyle(
                                          color: kBlack, fontSize: 22),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration:
                                      const BoxDecoration(color: kWhite),
                                  width: 130 / 3 - 2,
                                  height: double.infinity,
                                  child: const Center(
                                    child: Text(
                                      "1",
                                      style: TextStyle(
                                          color: kBlack, fontSize: 22),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(color: kButton),
                                  width: 130 / 3 - 3,
                                  height: double.infinity,
                                  child: const Center(
                                    child: Text(
                                      "+",
                                      style: TextStyle(
                                          color: kBlack, fontSize: 22),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Description",
                      style: TextStyle(color: kGold),
                    ),
                    const Text("Loritz Gold Mangalsutra"),
                    const SizedBox(height: 15),
                    const Text(
                      "Delivery Details",
                      style: TextStyle(color: kGold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.local_shipping_outlined, color: kGold),
                            Text("Delivery in 7-8 days"),
                          ],
                        ),
                        Row(
                          children: const [
                            Icon(Icons.support_agent, color: kGold),
                            Text("Order help & support"),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.inventory_2_outlined, color: kGold),
                            Text("Secure packaging"),
                          ],
                        ),
                        Row(
                          children: const [
                            Icon(Icons.sync, color: kGold),
                            Text("No return is allowed"),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            height: 50,
                            child: Image.asset("assets/image/bis.jpg")),
                        SizedBox(
                            height: 50,
                            child: Image.asset("assets/image/100cert.jpg")),
                        SizedBox(
                            height: 50,
                            child: Image.asset("assets/image/lifetime.png")),
                        SizedBox(
                            height: 50,
                            child: Image.asset("assets/image/delivery.jpg")),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
