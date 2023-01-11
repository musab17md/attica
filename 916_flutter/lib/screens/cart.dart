import 'package:flutter/material.dart';
import 'package:flutter_gold/ui_elements/constant.dart';
import 'package:sizer/sizer.dart';

import '../../ui_elements/colors.dart';
import '../../widgets/app_bar.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: kCardBackgroundColor,
        elevation: cardElevation,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "\$29,539",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  const Text("Total Amount"),
                ],
              ),
              SizedBox(
                  width: 150.sp,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: kButton),
                      onPressed: () {},
                      child: const Text("Continue"))),
            ],
          ),
        ),
      ),
      backgroundColor: kBackgroundColor,
      appBar: const MyAppBar2(
        title: "Cart",
        page: "cart",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CartItem(),
            const CartItem(),
            const CartItem(),
            const CartItem(),
            Card(
              elevation: cardElevation,
              color: kCardBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Apply a Coupon"),
                        Text("2 Coupons Available Now"),
                      ],
                    ),
                    const Card(
                      color: kGold,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Yay! You Saved \$10,789 on this order!"),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Product Total"),
                        Text("\$ 40,328.00"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Product Discount"),
                        Text("-\$ 10,789.00"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Delivery Charges"),
                        Text("\$ Free"),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Total Amount"),
                        Text("\$ 29,539"),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: kCardBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Orbit Diamond"),
                    const Text(
                      "Necklace",
                      style: TextStyle(color: kText2),
                    ),
                    Row(
                      children: [
                        Text(
                          "\$12,666 ",
                          style: TextStyle(fontSize: 15.sp),
                        ),
                        const Text(
                          "\$17,516",
                          style:
                              TextStyle(decoration: TextDecoration.lineThrough),
                        ),
                      ],
                    ),
                    infoPills("Gold: 14KT | 1.522 Gms"),
                    infoPills("Diamond: 0.07 Carat, SI IJ"),
                    infoPills("Size-5"),
                  ],
                ),
                Container(
                  width: 60.sp,
                  height: 60.sp,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/image/necklace.jpg"))),
                )
              ],
            ),
            Row(
              children: const [
                Icon(Icons.local_shipping_outlined),
                Text(" Delivery Between 17-Jan - 18 Jan"),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red[800],
                    ),
                    const Text("Remove"),
                  ],
                ),
                SizedBox(height: 30.sp, child: const VerticalDivider()),
                Row(
                  children: [
                    Icon(
                      Icons.favorite_outline,
                      color: Colors.red[800],
                    ),
                    const Text(" Move to wishlist"),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget infoPills(name) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: const BoxDecoration(
            color: kGold, borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            name,
            style: TextStyle(fontSize: 8.sp),
          ),
        ),
      ),
    );
  }
}
