import 'dart:convert';

import '../constant/urls.dart';
import '../core/api_client.dart';
import '../provider/SwitchUser.dart';
import '../screens/play_video.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

class ViewProduct extends StatefulWidget {
  final myData;
  const ViewProduct({super.key, required this.myData});

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  var data;

  viewVideo(video) {
    if (video == null) {
      return Card(
        child: Image.asset(
          "assets/video.png",
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          // openVideo("$url$video");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => VideoPlayerScreen(
                        url: "$video",
                      ))));
        },
        child: Card(
          child: Image.asset(
            "assets/video.png",
          ),
        ),
      );
    }
  }

  viewImage(image) {
    if (image == null) {
      return Card(
        child: Image.asset(
          "assets/placeholder.jpg",
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          debugPrint("$image");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => Scaffold(
                        body: Container(
                            child: PhotoView(
                          imageProvider: NetworkImage("$image"),
                        )),
                      ))));
        },
        child: Card(
          elevation: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
          child: Image.network(
            "$image",
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              );
            },
          ),
        ),
      );
    }
  }

  var photoJsonData;

  getPhoto() async {
    Response response = await ApiClient()
        .getData("http://$urlMain/pics/${data["image"].toString()}/");
    debugPrint("ListProdView: response body > ${response.body.toString()}");
    photoJsonData = jsonDecode(response.body);
    // widget.myData["model1"] = photoJsonData['model1'];
    // widget.myData["model2"] = photoJsonData['model2'];
    // widget.myData["pic1"] = photoJsonData['pic1'];
    // widget.myData["pic2"] = photoJsonData['pic2'];
    // widget.myData["pic3"] = photoJsonData['pic3'];
    // widget.myData["video"] = photoJsonData['video'];
    return jsonDecode(response.body);
  }

  postApprove() async {
    String authEndpoint = "http://$urlMain/noti/${widget.myData["id"]}/";

    debugPrint(authEndpoint);
    String body = jsonEncode({"status": "Approved"});
    Response response = await ApiClient().patchJson(authEndpoint, body);
    debugPrint(response.toString());
    if (response.statusCode.toString()[0] == "2") {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Result"),
              content: const Text("Approved Successfully."),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/home", (route) => false);
                      Navigator.pushNamed(context, "/listAllProd");
                    },
                    child: const Text("Done"))
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Failed"),
              content: Text(response.body.toString()),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Done")),
              ],
            );
          });
    }
  }

  postDeny() async {
    String authEndpoint = "http://$urlMain/noti/${widget.myData["id"]}/";
    debugPrint(authEndpoint);
    String body = jsonEncode({"status": "Rejected"});
    Response response = await ApiClient().patchJson(authEndpoint, body);
    debugPrint(response.toString());
    if (response.statusCode.toString()[0] == "2") {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Result"),
              content: const Text("Product Denied Successfully."),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/home", (route) => false);
                      Navigator.pushNamed(context, "/listProd");
                    },
                    child: const Text("Done"))
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Failed"),
              content: Text(response.body.toString()),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Done"))
              ],
            );
          });
    }
  }

  getButton(stat) {
    if (stat == "Rejected") {
      if (context.watch<SwithUser>().currUser == "Admin") {
        return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {},
            child: const Text("Delete (dev)"));
      }
      return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: () {},
          child: const Text("Edit (dev)"));
      // NOTES: Avoid Edit for vendor during Pending Status, Because Vendor could have edited during Admin verify process.
    }
    if (stat == "Pending" && context.watch<SwithUser>().currUser == "Admin") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                postDeny();
              },
              child: const Text("Deny")),
          const SizedBox(width: 40),
          ElevatedButton(
              onPressed: () {
                postApprove();
              },
              child: const Text("Approve")),
        ],
      );
    } else {
      return const SizedBox(
        height: 1,
        width: 1,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint(widget.myData.toString());
    data = widget.myData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product #${data["id"]}"),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Column(
            children: [
              FutureBuilder(
                  future: getPhoto(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            data["product_name"],
                            style: const TextStyle(fontSize: 30.0),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: DataTable(
                              columns: const <DataColumn>[
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Title',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Description',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                              ],
                              rows: <DataRow>[
                                DataRow(
                                  cells: <DataCell>[
                                    const DataCell(Text('Vendor Name')),
                                    DataCell(Text(photoJsonData["vendor"])),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    const DataCell(Text("Ornament Type")),
                                    DataCell(
                                      Text(photoJsonData["ornament"]),
                                    ),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    const DataCell(Text('Time')),
                                    DataCell(Text(photoJsonData["time"])),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    const DataCell(Text('Date')),
                                    DataCell(Text(photoJsonData["date"])),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              height: 250,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  // viewImage(widget.myData["model1"]),
                                  // viewImage(widget.myData["model2"]),
                                  // viewImage(widget.myData["pic1"]),
                                  // viewImage(widget.myData["pic2"]),
                                  // viewImage(widget.myData["pic3"]),
                                  // viewVideo(widget.myData["video"]),
                                  viewImage(photoJsonData["model1"]),
                                  viewImage(photoJsonData["model2"]),
                                  viewImage(photoJsonData["pic1"]),
                                  viewImage(photoJsonData["pic2"]),
                                  viewImage(photoJsonData["pic3"]),
                                  viewVideo(photoJsonData["video"]),
                                ],
                              )),
                          const SizedBox(height: 20),
                        ],
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: DataTable(
                  // columns: const <DataColumn>[
                  //   DataColumn(
                  //     label: Expanded(
                  //       child: Text(
                  //         'Title',
                  //         style: TextStyle(fontStyle: FontStyle.italic),
                  //       ),
                  //     ),
                  //   ),
                  //   DataColumn(
                  //     label: Expanded(
                  //       child: Text(
                  //         'Description',
                  //         style: TextStyle(fontStyle: FontStyle.italic),
                  //       ),
                  //     ),
                  //   ),
                  // ],
                  columns: <DataColumn>[
                    DataColumn(
                      label: Container(),
                    ),
                    DataColumn(
                      label: Container(),
                    ),
                  ],
                  rows: <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text("Product Name")),
                        DataCell(Text(data["product_name"])),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text("Metal")),
                        DataCell(Text(data["metal"])),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('Ornament')),
                        DataCell(Text(data["ornament"])),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('Purity %')),
                        DataCell(Text(data["purity"])),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('24K Rate')),
                        DataCell(Text(data["rate"])),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('Gross Weight')),
                        DataCell(Text(data["grossw"])),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('Stone Weight')),
                        DataCell(Text(data["stonew"])),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('Making Charges')),
                        DataCell(Text(data["makingc"])),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('Wastage Charges')),
                        DataCell(Text(data["wastagec"])),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('Stone Charges ₹')),
                        DataCell(Text(data["stonec"])),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('Net Weight')),
                        DataCell(Text(data["netw"])),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('Net Amount')),
                        DataCell(Text(data["neta"])),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('Total (NA + MC + WC + SC)')),
                        DataCell(Text(data["totala"])),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('Validity Date')),
                        DataCell(Text(data["vaildd"].toString())),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('Quantity')),
                        DataCell(Text(data["qty"].toString())),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('Vendor')),
                        DataCell(Text(data["vendor"].toString())),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('Submit Date')),
                        DataCell(Text(data["submitdate"].toString())),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('Image id')),
                        DataCell(Text(data["image"].toString())),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('Status')),
                        DataCell(Text(data["status"].toString())),
                      ],
                    ),
                  ],
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     ElevatedButton(
              //         onPressed: () {
              //           postDeny();
              //         },
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: Colors.red,
              //         ),
              //         child: const Text("Deny")),
              //     ElevatedButton(
              //         onPressed: () {
              //           postApprove();
              //         },
              //         child: const Text("Approve")),
              //   ],
              // ),
              getButton(widget.myData["status"]),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
