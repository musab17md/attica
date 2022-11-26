import 'dart:convert';

import 'package:flutter/material.dart';

import '../constant/navbar.dart';
import '../constant/urls.dart';
import '../constant/vars.dart';
import '../core/api_client.dart';

class ListGoldRate extends StatelessWidget {
  const ListGoldRate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDraw(),
      appBar: AppBar(
        title: const Text("Add Gold Rate"),
      ),
      body: const CurrentGoldRates(),
    );
  }
}

class CurrentGoldRates extends StatefulWidget {
  const CurrentGoldRates({super.key});

  @override
  State<CurrentGoldRates> createState() => _CurrentGoldRatesState();
}

class _CurrentGoldRatesState extends State<CurrentGoldRates> {
  List? data;
  List? mydata;

  Future getDataListGold() async {
    var userk = await getUser();
    final response = await ApiClient().getData('http://$urlMain/gold/');
    debugPrint(response.body);
    data = jsonDecode(response.body);
    debugPrint("ListVendorGold: getData length > ${data!.length}");
    setState(() {
      mydata = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getDataListGold();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: ListView.builder(
        itemCount: mydata == null ? 0 : mydata?.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              // leading: SizedBox(
              //   height: 50,
              //   width: 50,
              //   // decoration:
              //   //     BoxDecoration(border: Border.all(color: Colors.black)),
              //   child: Center(child: Text(mydata![index]["metal"])),
              // ),
              title: Text(mydata![index]["vendor"]),
              subtitle: Row(
                children: [
                  Text(
                    mydata![index]["metal"],
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(mydata![index]["rate"]),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(mydata![index]["date"]),
                  Text(mydata![index]["time"]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AllGoldRates extends StatefulWidget {
  const AllGoldRates({super.key});

  @override
  State<AllGoldRates> createState() => _AllGoldRatesState();
}

class _AllGoldRatesState extends State<AllGoldRates> {
  List? data;
  List? mydata;

  dataNum() {
    if (data!.length == 1) {
      return [data![data!.length - 1]];
    }
    if (data!.length == 2) {
      return [data![data!.length - 1], data![data!.length - 2]];
    }
    if (data!.length >= 3) {
      return [
        data![data!.length - 1],
        data![data!.length - 2],
        data![data!.length - 3]
      ];
    }
  }

  Future getDataListGold() async {
    var userk = await getUser();
    final response =
        await ApiClient().getData('http://$urlMain/gold/${userk[0]}/');
    debugPrint(response.body);
    data = jsonDecode(response.body);
    debugPrint("ListVendorGold: getData length > ${data!.length}");
    setState(() {
      mydata = dataNum();
    });
  }

  @override
  void initState() {
    super.initState();
    getDataListGold();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: mydata == null ? 0 : mydata?.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              // leading: SizedBox(
              //   height: 50,
              //   width: 50,
              //   // decoration:
              //   //     BoxDecoration(border: Border.all(color: Colors.black)),
              //   child: Center(child: Text(mydata![index]["metal"])),
              // ),
              subtitle: Row(
                children: [
                  Text(
                    mydata![index]["metal"],
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(mydata![index]["rate"]),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(mydata![index]["date"]),
                  Text(mydata![index]["time"]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
