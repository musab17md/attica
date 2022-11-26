import 'dart:convert';

import 'package:ecom/screens/add_gold_rate.dart';
import 'package:ecom/tests/addprod4.dart';
import 'package:flutter/material.dart';

import '../constant/urls.dart';
import '../core/api_client.dart';
import '../screens/list_photo_by_id.dart';
import '../screens/list_prod.dart';
import '../screens/list_prod_by_id.dart';

class ShortcutIconBar extends StatefulWidget {
  const ShortcutIconBar({super.key, required this.userdetail});
  final List? userdetail;

  @override
  State<ShortcutIconBar> createState() => _ShortcutIconBarState();
}

class _ShortcutIconBarState extends State<ShortcutIconBar> {
  List? data;
  List mydata = [];

  Future getDataListGold() async {
    final response = await ApiClient().getData('http://$urlMain/gold/');
    debugPrint(response.body);
    data = jsonDecode(response.body);
    debugPrint("ListVendorGold: getData length > ${data!.length}");
    uniqueRates();
    return "success";
  }

  uniqueRates() {
    List unq = [];
    List unqid = [];
    data = data!.reversed.toList();
    for (var d in data!) {
      // debugPrint(d.toString());
      if (unqid.contains(d["vendor_id"]) == false) {
        unq.add(d);
        unqid.add(d["vendor_id"]);
      }
    }
    debugPrint(unq.toString());
    mydata = unq;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          //vendor > Add Prod , Add Gold Rate , Photo Req , List My Prod
          if (widget.userdetail![1] == "Vendor")
            iconButtons(Icons.add, "Add Product", context, const AddProduct4()),
          if (widget.userdetail![1] == "Vendor")
            iconButtons(Icons.monetization_on_outlined, "Gold Rate : \$5000",
                context, const AddGoldRate()),
          if (widget.userdetail![1] == "Vendor")
            iconButtons(Icons.airplay_rounded, "Product", context,
                const ListProductOfVendor()),
          if (widget.userdetail![1] == "Vendor")
            iconButtons(Icons.photo_camera, "Photo Requests", context,
                const ListPhotoByID()),
          //admin >
          if (widget.userdetail![1] == "Admin")
            iconButtons(
                Icons.airplay_rounded, "Product", context, const ListProduct()),
          if (widget.userdetail![1] == "Admin") iconButtonsRate(),
          // iconButtonsRate(
          //     Icons.monetization_on_outlined, "Gold Rate : \$5000", context),
          // if (userdetail![1] == "Admin") const VendorsList(),
          // iconButtons(
          //     Icons.monetization_on_outlined, "Gold Rate : \$5000", context),
          // Photo
        ],
      ),
    );
  }

  Widget iconButtonsRate() {
    return FutureBuilder(
        future: getDataListGold(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              children: [
                for (var m in mydata)
                  iconButtons2(Icons.monetization_on_outlined,
                      "Gold Rate : \$${m["rate"]}", context, m["vendor"]),
              ],
            );
          }
          return Container();
        });
  }

  Widget iconButtons(IconData iconName, String name, context, nav) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: ((context) => nav)));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.0),
        ),
        color: const Color.fromARGB(255, 224, 190, 66),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Icon(
                iconName,
                color: const Color.fromARGB(255, 35, 75, 64),
                size: 30.0,
              ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 35, 75, 64),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget iconButtons2(IconData iconName, String name, context, vendName) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.0),
        ),
        color: const Color.fromARGB(255, 224, 190, 66),
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Row(
            children: [
              Icon(
                iconName,
                color: const Color.fromARGB(255, 35, 75, 64),
                size: 30.0,
              ),
              Column(
                children: [
                  Text(
                    vendName,
                    style: const TextStyle(fontSize: 12),
                  ),
                  Row(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 35, 75, 64),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// class VendorsList extends StatelessWidget {
//   const VendorsList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return iconButtons(
//               Icons.monetization_on_outlined, "Gold Rate : \$5000", context) iconButtons(
//               Icons.monetization_on_outlined, "Gold Rate : \$5000", context);
//   }
// }
