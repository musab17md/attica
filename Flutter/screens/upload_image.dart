import 'package:attica/constant/navbar.dart';
import 'package:attica/constant/urls.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class UploadProductProgress extends StatelessWidget {
  const UploadProductProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDraw(),
      appBar: AppBar(
        title: const Text("Uploading. . ."),
      ),
      body: const Upload(),
    );
  }
}

class Upload extends StatefulWidget {
  const Upload({super.key});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  String progress = "";
  String percentage = "";

  getFilePath(name, ext) async {
    final path = await getDir();
    return '$path/$name.$ext';
  }

  getDir() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  uploadImage() async {
    // final prefs = await SharedPreferences.getInstance();
    // debugPrint(prefs.getStringList("last_image").toString());
    // // String url = "http://192.168.0.134/connect_database/uploadimage2.php";
    // // String url = "http://192.168.0.75/all/xsubmit.php";
    // String url = "http://192.168.0.134:8123/pics/";
    // // String file = "/data/user/0/com.example.ecom/app_flutter/ProdVideo.mp4";
    // // String file1 = "/data/user/0/com.example.ecom/app_flutter/ProdPic1.jpg";
    // // String file2 = "/data/user/0/com.example.ecom/app_flutter/ProdPic2.jpg";
    // // String file3 = "/data/user/0/com.example.ecom/app_flutter/ProdPic3.jpg";
    // // String file4 = "/data/user/0/com.example.ecom/app_flutter/ModalPic1.jpg";
    // // String file5 = "/data/user/0/com.example.ecom/app_flutter/ModalPic2.jpg";
    // String file = prefs.getStringList("last_image")![7];
    // String file1 = prefs.getStringList("last_image")![4];
    // String file2 = prefs.getStringList("last_image")![5];
    // String file3 = prefs.getStringList("last_image")![6];
    // String file4 = prefs.getStringList("last_image")![8];
    // String file5 = prefs.getStringList("last_image")![9];
    // FormData formdata = FormData.fromMap({
    //   "submitCustomer": "",
    //   "vendor": prefs.getStringList("last_image")![0],
    //   "ornament": prefs.getStringList("last_image")![1],
    //   "file2": await MultipartFile.fromFile(file, filename: "ProdVideo.mp4"),
    //   "file3": await MultipartFile.fromFile(file1, filename: "ProdPic1.jpg"),
    //   "file4": await MultipartFile.fromFile(file2, filename: "ProdPic2.jpg"),
    //   "file5": await MultipartFile.fromFile(file3, filename: "ProdPic3.jpg"),
    //   "file": await MultipartFile.fromFile(file4, filename: "ModalPic1.jpg"),
    //   "file1": await MultipartFile.fromFile(file5, filename: "ModalPic2.jpg"),
    //   "time": vars.time,
    //   "date": vars.date,
    //   "status": "Pending"
    // });

    var request = http.MultipartRequest('POST', addPics);
    request.fields.addAll({
      'vendor': 'musab',
      'time': '10:21:00',
      'date': '10/11/2022',
      'status': 'Pending',
      'ornament': 'Ring'
    });
    request.files.add(await http.MultipartFile.fromPath(
        'model1', "/data/user/0/com.example.ecom/app_flutter/ModalPic1.jpg"));
    request.files.add(await http.MultipartFile.fromPath(
        'model2', "/data/user/0/com.example.ecom/app_flutter/ModalPic1.jpg"));
    request.files.add(await http.MultipartFile.fromPath(
        'video', "/data/user/0/com.example.ecom/app_flutter/ModalPic1.jpg"));
    request.files.add(await http.MultipartFile.fromPath(
        'pic1', "/data/user/0/com.example.ecom/app_flutter/ModalPic1.jpg"));
    request.files.add(await http.MultipartFile.fromPath(
        'pic2', "/data/user/0/com.example.ecom/app_flutter/ModalPic1.jpg"));
    request.files.add(await http.MultipartFile.fromPath(
        'pic3', "/data/user/0/com.example.ecom/app_flutter/ModalPic1.jpg"));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      debugPrint(await response.stream.bytesToString());
      debugPrint(response.headers.toString());
    } else {
      debugPrint(response.reasonPhrase);
      debugPrint(response.headers.toString());
      debugPrint(response.request.toString());
    }

    // var response = await http.post(
    //   Uri.parse(url),
    //   headers: {
    //     "Content-Type": 'application/json',
    //     // "Accept": 'application/json'
    //     // 'Authorization': 'Token $token',
    //   },
    //   body: jsonEncode({
    //     'vendor': "metalValue",
    //     'ornament': "ornamentValue",
    //     'time': "10:10:10",
    //     'date': "09/11/2022",
    //     'status': "pending"
    //   }),
    // );
    // debugPrint(response.body);

    //   Dio dio = Dio();
    //   dio.options.validateStatus = (status) => true;
    //   try {
    //     Response response = await dio.post(
    //       url,
    //       data: formdata,
    //       onSendProgress: ((count, total) {
    //         percentage = (count / total * 100).toStringAsFixed(2);
    //         setState(() {
    //           progress = "$count / $percentage";
    //         });
    //       }),
    //     );
    //     debugPrint(response.toString());
    //   } catch (e) {
    //     debugPrint("Error.");
    //     debugPrint(e.toString());
    //   }

    debugPrint("Uploading Completed");
  }

  // @override
  // void initState() {
  //   super.initState();

  //   uploadImage();
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          FutureBuilder(
              future: uploadImage(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Container();
              }),
          Text(progress),
          // SimpleCircularProgressBar(
          //   mergeMode: true,
          //   onGetText: (double percentage) {
          //     return Text('${percentage.toInt()}%');
          //   },
          // ),
          ElevatedButton(
              onPressed: () {
                uploadImage();
              },
              child: const Text("Post")),
        ],
      ),
    );
  }
}
