import 'dart:convert';
import 'dart:io';

import '../constant/image_view.dart';
import '../constant/urls.dart';
import '../core/api_client.dart';
import '../screens/play_video.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:photo_view/photo_view.dart';
import '../constant/urls.dart' as urls;

class ViewImage extends StatefulWidget {
  final myData;
  const ViewImage({super.key, required this.myData});

  @override
  State<ViewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  getImage(path) {
    var fullPath = "/data/user/0/com.example.ecom/app_flutter/$path";
    if (File(fullPath).existsSync()) {
      return Image.file(
        File(fullPath),
        // width: (width / 2) - 30,
      );
    }
    return Image.asset(
      "assets/placeholder.jpg",
      // width: (width / 2) - 30,
    );
  }

  getVideo(path) {
    var fullPath = "/data/user/0/com.example.ecom/app_flutter/$path";
    if (File(fullPath).existsSync()) {
      return Image.asset(
        "assets/video.png",
        // width: (width / 2) - 30,
      );
    }
    return Image.asset(
      "assets/placeholder.jpg",
      // width: (width / 2) - 30,
    );
  }

  var urlModel = urls.urlModel;
  var urlProd = urls.urlProd;
  var urlVideo = urls.urlVideo;

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

  postDeny() async {
    String authEndpoint = "http://$urlMain/pics/${widget.myData["id"]}/";
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
                      Navigator.pushNamed(context, "/listPhoto");
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

  postApprove() async {
    String authEndpoint = "http://$urlMain/pics/${widget.myData["id"]}/";
    debugPrint(authEndpoint);
    String body = jsonEncode({"status": "Accepted"});
    Response response = await ApiClient().patchJson(authEndpoint, body);
    debugPrint(response.toString());
    if (response.statusCode.toString()[0] == "2") {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Result"),
              content: const Text("Post Successful."),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/home", (route) => false);
                      Navigator.pushNamed(context, "/listPhoto");
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

  getButton(stat) {
    if (stat == "Rejected") {
      // return ElevatedButton(
      //     style: ElevatedButton.styleFrom(
      //       backgroundColor: Colors.red,
      //     ),
      //     onPressed: () {},
      //     child: const Text("Delete"));
      return const SizedBox(
        height: 1,
        width: 1,
      );
    }
    if (stat == "Pending") {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Product #${widget.myData["id"]}"),
      ),
      body: Card(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "Uploaded Images",
                style: TextStyle(fontSize: 20.0),
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
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Description',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ],
                  rows: <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('Vendor Name')),
                        DataCell(Text(widget.myData["vendor"])),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text("Ornament Type")),
                        DataCell(
                          Text(widget.myData["ornament"]),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('Time')),
                        DataCell(Text(widget.myData["time"])),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('Date')),
                        DataCell(Text(widget.myData["date"])),
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
                      // viewImage(urlModel, widget.myData["model1"]),
                      // viewImage(urlModel, widget.myData["model2"]),
                      // viewImage(urlProd, widget.myData["pic1"]),
                      // viewImage(urlProd, widget.myData["pic2"]),
                      // viewImage(urlProd, widget.myData["pic3"]),
                      // viewVideo(urlVideo, widget.myData["video"]),

                      viewImage(widget.myData["model1"]),
                      viewImage(widget.myData["model2"]),
                      viewImage(widget.myData["pic1"]),
                      viewImage(widget.myData["pic2"]),
                      viewImage(widget.myData["pic3"]),
                      viewVideo(widget.myData["video"]),

                      // scrollImg("ProdPic1.jpg", context),
                      // scrollImg("ProdPic2.jpg", context),
                      // scrollImg("ProdPic3.jpg", context),
                      // scrollVid("ProdVideo.mp4"),
                      // scrollImg("ModalPic1.jpg", context),
                      // scrollImg("ModalPic2.jpg", context),
                    ],
                  )),
              const SizedBox(height: 20),
              getButton(widget.myData["status"])
            ],
          ),
        ),
      ),
    );
  }

  Widget scrollImg(String name, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => FullImage(
                      name: "/data/user/0/com.example.ecom/app_flutter/$name",
                    ))));
      },
      child: Card(
        elevation: 8.0,
        margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
        child: getImage(name),
      ),
    );
  }

  Widget scrollVid(String name) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
      child: getVideo(name),
    );
  }
}
