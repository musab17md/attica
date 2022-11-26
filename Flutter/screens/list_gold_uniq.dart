import 'dart:convert';

import 'package:ecom/constant/vars.dart';
import 'package:flutter/material.dart';

import '../constant/navbar.dart';
import '../constant/urls.dart';
import '../core/api_client.dart';

class ListUnqGoldRate extends StatefulWidget {
  const ListUnqGoldRate({super.key});

  @override
  State<ListUnqGoldRate> createState() => _ListUnqGoldRateState();
}

class _ListUnqGoldRateState extends State<ListUnqGoldRate> {
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
    return Scaffold(
      backgroundColor: MyColorOld().background(),
      drawer: const NavDraw(),
      appBar: AppBar(
        title: const Text("Gold Rates"),
      ),
      body: FutureBuilder(
          future: getDataListGold(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: mydata == null ? 0 : mydata.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Text(mydata[index]["vendor"]),
                      subtitle: Row(
                        children: [
                          Text(
                            mydata[index]["metal"],
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(mydata[index]["rate"]),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(mydata[index]["date"]),
                          Text(mydata[index]["time"]),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

// class UnqGoldRates extends StatefulWidget {
//   const UnqGoldRates({super.key});

//   @override
//   State<UnqGoldRates> createState() => _UnqGoldRatesState();
// }

// class _UnqGoldRatesState extends State<UnqGoldRates> {
//   List? data;
//   List? mydata;

//   Future getDataListGold() async {
//     var userk = await getUser();
//     final response = await ApiClient().getData('http://$urlMain/gold/');
//     debugPrint(response.body);
//     data = jsonDecode(response.body);
//     debugPrint("ListVendorGold: getData length > ${data!.length}");
//     uniqueRates();
//     return "success";
//   }

//   uniqueRates() {
//     List unq = [];
//     List unqid = [];
//     for (var d in data!) {
//       debugPrint(d.toString());
//       if (unqid.contains(d["vendor_id"]) == false) {
//         unq.add(d);
//         unqid.add(d["vendor_id"]);
//       }
//     }
//     debugPrint(unq.toString());
//     setState(() {
//       mydata = unq;
//     });
//   }

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   getDataListGold();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: getDataListGold(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return Text(mydata.toString());
//           }
//           return const Center(child: CircularProgressIndicator());
//         });
//   }
// }

// Expanded(
//               child: ListView.builder(
//                 itemCount: mydata == null ? 0 : mydata?.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Card(
//                     child: ListTile(
//                       subtitle: Row(
//                         children: [
//                           Text(
//                             mydata![index]["metal"],
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           Text(mydata![index]["rate"]),
//                         ],
//                       ),
//                       trailing: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(mydata![index]["date"]),
//                           Text(mydata![index]["time"]),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             )