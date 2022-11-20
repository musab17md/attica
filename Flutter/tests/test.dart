import 'package:attica/constant/navbar.dart';
import 'package:attica/constant/urls.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDraw(),
      appBar: AppBar(
        title: const Text("Test Page"),
      ),
      body: const MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final ImagePicker _picker = ImagePicker();
  XFile? pickedImage;
  XFile? pickedVideo;

  pickImg() async {
    pickedImage = await _picker.pickImage(source: ImageSource.gallery);
  }

  pickVid() async {
    pickedVideo = await _picker.pickVideo(source: ImageSource.gallery);
  }

  post() async {
    var request = http.MultipartRequest('POST', addPics);
    request.fields.addAll({
      'vendor': 'musab34',
      'time': '10:21:00',
      'date': '10/11/2022',
      'status': 'Pending',
      'ornament': 'Ring'
    });

    // var image = "/storage/emulated/0/download/gold_image.jpeg";
    // var video = "/storage/emulated/0/download/video.mp4";

    debugPrint(pickedImage!.path);
    debugPrint(pickedImage!.path.runtimeType.toString());
    debugPrint(pickedImage!.runtimeType.toString());
    debugPrint(pickedImage!.name);

    request.files
        .add(await http.MultipartFile.fromPath('model1', pickedImage!.path));
    request.files
        .add(await http.MultipartFile.fromPath('model2', pickedImage!.path));
    request.files
        .add(await http.MultipartFile.fromPath('video', pickedVideo!.path));
    request.files
        .add(await http.MultipartFile.fromPath('pic1', pickedImage!.path));
    request.files
        .add(await http.MultipartFile.fromPath('pic2', pickedImage!.path));
    request.files
        .add(await http.MultipartFile.fromPath('pic3', pickedImage!.path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      debugPrint(await response.stream.bytesToString());
    } else {
      debugPrint(response.reasonPhrase);
    }
  }

  // postTest() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   debugPrint(prefs.getStringList("last_image").toString());
  //   // String url = "http://192.168.0.134/connect_database/uploadimage2.php";
  //   // String url = "http://192.168.0.75/all/xsubmit.php";
  //   String url = "http://192.168.0.134:8123/pics/";
  //   // String file = "/data/user/0/com.example.ecom/app_flutter/ProdVideo.mp4";
  //   // String file1 = "/data/user/0/com.example.ecom/app_flutter/ProdPic1.jpg";
  //   // String file2 = "/data/user/0/com.example.ecom/app_flutter/ProdPic2.jpg";
  //   // String file3 = "/data/user/0/com.example.ecom/app_flutter/ProdPic3.jpg";
  //   // String file4 = "/data/user/0/com.example.ecom/app_flutter/ModalPic1.jpg";
  //   // String file5 = "/data/user/0/com.example.ecom/app_flutter/ModalPic2.jpg";
  //   String file = prefs.getStringList("last_image")![7];
  //   String file1 = prefs.getStringList("last_image")![4];
  //   String file2 = prefs.getStringList("last_image")![5];
  //   String file3 = prefs.getStringList("last_image")![6];
  //   String file4 = prefs.getStringList("last_image")![8];
  //   String file5 = prefs.getStringList("last_image")![9];

  //   FormData formdata = FormData.fromMap({
  //     "submitCustomer": "",
  //     "vendor": prefs.getStringList("last_image")![0],
  //     "ornament": prefs.getStringList("last_image")![1],
  //     "file2": await MultipartFile.fromFile(file, filename: "ProdVideo.mp4"),
  //     "file3": await MultipartFile.fromFile(file1, filename: "ProdPic1.jpg"),
  //     "file4": await MultipartFile.fromFile(file2, filename: "ProdPic2.jpg"),
  //     "file5": await MultipartFile.fromFile(file3, filename: "ProdPic3.jpg"),
  //     "file": await MultipartFile.fromFile(file4, filename: "ModalPic1.jpg"),
  //     "file1": await MultipartFile.fromFile(file5, filename: "ModalPic2.jpg"),
  //   });

  //   debugPrint("posting data");
  //   // var response = await http.post(
  //   //   Uri.parse(url),
  //   //   headers: {
  //   //     'Content-Type': 'application/json',
  //   //     'Authorization': 'Token $token',
  //   //   },
  //   //   body: jsonEncode({
  //   //     'vendor': "metalValue",
  //   //     'ornament': "ornamentValue",
  //   //     'time': "10:10:10",
  //   //     'date': "09/11/2022",
  //   //     'status': "pending"
  //   //   }),
  //   // );

  //   Dio dio = Dio();
  //   // dio.options.headers['content-Type'] = 'multipart/form-data';
  //   // dio.options.headers["authorization"] = "token $token";
  //   try {
  //     Response response = await dio.post(
  //       url,
  //       data: formdata,
  //       options: Options(
  //         validateStatus: (status) => true,
  //       ),
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

  //   debugPrint("Uploading Completed");

  //   debugPrint("Completed posting data");

  //   debugPrint("Post req done");
  //   // debugPrint(response.statusCode.toString());
  //   // debugPrint(response.body.toString());
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                pickImg();
              },
              child: const Text("Pick Image")),
          ElevatedButton(
              onPressed: () {
                pickVid();
              },
              child: const Text("Pick Video")),
          ElevatedButton(
              onPressed: () {
                post();
              },
              child: const Text("Post")),
        ],
      ),
    );
  }
}
