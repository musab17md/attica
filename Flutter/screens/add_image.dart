import '../constant/navbar.dart';
import '../core/api_client.dart';
import '../screens/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constant/urls.dart' as urls;

class AddProductImage extends StatefulWidget {
  const AddProductImage({super.key});

  @override
  State<AddProductImage> createState() => _AddProductImageState();
}

class _AddProductImageState extends State<AddProductImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDraw(),
      appBar: AppBar(
        title: const Text("Add Product Image"),
      ),
      body: const AddImageWidget(),
    );
  }
}

// List<String> vendors = <String>[];
const List<String> ornaments = <String>[
  "Anklets",
  "Baby Bangles",
  "Bangles",
  "Bracelet",
  "Broad Bangles",
  "Chain",
  "Chain with Locket",
  "Drops",
  "Ear Rings",
  "Gold Bar",
  "Locket",
  "Matti",
  "Necklace",
  "Ring",
  "Silver Bar",
  "Silver Items",
  "Studs And Drops",
  "Thali Chain",
  "Waist Belt/Chain"
];

String date = DateFormat('yMd').format(DateTime.now());
String time = DateFormat('HH:mm:ss').format(DateTime.now());

class AddImageWidget extends StatefulWidget {
  const AddImageWidget({super.key});

  @override
  State<AddImageWidget> createState() => _AddImageWidgetState();
}

class _AddImageWidgetState extends State<AddImageWidget> {
  bool _isLoading = false;
  String? _selectedVendor;
  String? _selectedOrnament;
  final _formKey = GlobalKey<FormState>();
  XFile? modalPic1;
  XFile? modalPic2;
  XFile? prodVideo;
  XFile? prodPic1;
  XFile? prodPic2;
  XFile? prodPic3;

  // String url = "http://192.168.0.134/connect_database/uploadimage2.php";
  String progress = "";

  String mPic1 = "";
  String mPic2 = "";
  String pVideo = "";
  String pPic1 = "";
  String pPic2 = "";
  String pPic3 = "";

  submitForm(context) async {
    List<String> myList = [
      _selectedVendor ?? "",
      _selectedOrnament ?? "",
      time,
      date,
      "",
      "",
      "",
      "",
      "",
      "",
    ];

    if (_selectedVendor != "" &&
        _selectedOrnament != "" &&
        modalPic1 != null &&
        modalPic2 != null &&
        prodVideo != null &&
        prodPic1 != null &&
        prodPic2 != null &&
        prodPic3 != null) {
      String ext;
      String currDir = "";
      getDir().then((value) async {
        currDir = value;

        ext = prodPic1!.name.split(".")[1];
        myList[4] = "$currDir/ProdPic1.$ext";
        pPic1 = myList[4];
        prodPic1!.saveTo(pPic1);

        ext = prodPic2!.name.split(".")[1];
        myList[5] = "$currDir/ProdPic2.$ext";
        pPic2 = myList[5];
        prodPic2!.saveTo(pPic2);

        ext = prodPic3!.name.split(".")[1];
        myList[6] = "$currDir/ProdPic3.$ext";
        pPic3 = myList[6];
        prodPic3!.saveTo(pPic3);

        ext = prodVideo!.name.split(".")[1];
        myList[7] = "$currDir/ProdVideo.$ext";
        pVideo = myList[7];
        prodVideo!.saveTo(pVideo);

        ext = modalPic1!.name.split(".")[1];
        myList[8] = "$currDir/ModalPic1.$ext";
        mPic1 = myList[8];
        modalPic1!.saveTo(mPic1);

        ext = modalPic2!.name.split(".")[1];
        myList[9] = "$currDir/ModalPic2.$ext";
        mPic2 = myList[9];
        modalPic2!.saveTo(mPic2);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setStringList('last_image', myList).then((value) {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => const UploadProductProgress())));
        });
      });
    } else {
      debugPrint("Please fill all required labels");
      // _showAction(context, "Please fill all required labels");
      // _showAction(context);
    }
  }

  String currentUserId = "";

  getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    currentUserId = prefs.getStringList("userkey")![0];
  }

  submitForm2() async {
    var request = http.MultipartRequest('POST', urls.addPics);
    var svend = _selectedVendor!.split(", ");
    request.fields.addAll({
      'vendor': svend[1].toString(),
      'vendor_id': svend[0].toString(),
      'time': time,
      'date': date,
      'status': 'Pending',
      'ornament': _selectedOrnament.toString(),
      'photographer_id': currentUserId,
    });

    // var image = "/storage/emulated/0/download/gold_image.jpeg";
    // var video = "/storage/emulated/0/download/video.mp4";

    request.files
        .add(await http.MultipartFile.fromPath('model1', modalPic1!.path));
    request.files
        .add(await http.MultipartFile.fromPath('model2', modalPic2!.path));
    request.files
        .add(await http.MultipartFile.fromPath('video', prodVideo!.path));
    request.files
        .add(await http.MultipartFile.fromPath('pic1', prodPic1!.path));
    request.files
        .add(await http.MultipartFile.fromPath('pic2', prodPic2!.path));
    request.files
        .add(await http.MultipartFile.fromPath('pic3', prodPic3!.path));

    http.StreamedResponse response = await request.send();

    String result = "";
    if (response.statusCode.toString()[0] == "2") {
      result = "Submitted Successfully";
      debugPrint(await response.stream.bytesToString());
    } else {
      result = "Failed Submission";
      debugPrint(response.reasonPhrase);
    }
    setState(() {
      _isLoading = false;
    });

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text("result"),
            content: Text(result),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Done"),
              ),
            ],
          );
        });
  }

  clearImage() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('last_image');
  }

  getTextImg(mod) {
    if (mod != null) {
      return mod.name;
    } else {
      return "Select an image";
    }
  }

  loadModal1() async {
    final ImagePicker picker = ImagePicker();
    modalPic1 = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (modalPic1 != null) {
      setState(() {});
    } else {
      debugPrint("User cancelled the picker");
    }
  }

  loadModal2() async {
    final ImagePicker picker = ImagePicker();
    modalPic2 = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (modalPic2 != null) {
      setState(() {});
    } else {
      debugPrint("User cancelled the picker");
    }
  }

  loadProdVideo() async {
    final ImagePicker picker = ImagePicker();
    prodVideo = await picker.pickVideo(
      source: ImageSource.gallery,
    );
    if (prodVideo != null) {
      setState(() {});
    } else {
      debugPrint("User cancelled the picker");
    }
  }

  // loadProdPic1() async {
  //   prodPic1 = await FilePicker.platform.pickFiles();
  //   if (prodVideo != null) {
  //     PlatformFile file = prodPic1!.files.first;
  //     setState(() {});
  //     debugPrint(
  //         "File Name - ${file.name}, Bytes - ${file.bytes}, Size - ${file.size}, Ext - ${file.extension}, Path - ${file.path}");
  //   } else {
  //     debugPrint("User cancelled the picker");
  //   }
  // }

  loadProdPic1() async {
    final ImagePicker picker = ImagePicker();
    prodPic1 = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (prodPic1 != null) {
      setState(() {});
    } else {
      debugPrint("User cancelled the picker");
    }
  }

  loadProdPic2() async {
    final ImagePicker picker = ImagePicker();
    prodPic2 = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (prodPic2 != null) {
      setState(() {});
    } else {
      debugPrint("User cancelled the picker");
    }
  }

  loadProdPic3() async {
    final ImagePicker picker = ImagePicker();
    prodPic3 = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (prodPic3 != null) {
      setState(() {});
      // debugPrint(prodPic3);

      // String ext = prodPic3!.name.split(".")[1];
      // var savepath = await getFilePath("ProdPic3", ext);
      // prodPic3!.saveTo(savepath);
    } else {
      debugPrint("User cancelled the picker");
    }
  }

  getFilePath(name, ext) async {
    final path = await getDir();
    return '$path/$name.$ext';
  }

  getDir() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  loadTest() async {
    final directory = await getApplicationDocumentsDirectory();
    debugPrint(directory.path);
    String path = directory.path;

    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    debugPrint("###################");
    if (pickedFile != null) {
      String ext = pickedFile.name.split(".")[1];
      String savepath = "$path/image1.$ext";
      debugPrint(savepath);
      pickedFile.saveTo(savepath);
    } else {
      debugPrint("picked File is None");
    }
  }

  // List vendorData = [];
  // getVendorList() async {
  //   var resp = await ApiClient().getVendorList();
  //   debugPrint(resp.toString());
  //   setState(() {
  //     vendorData = resp;
  //   });
  // }

  List<String> vendors = <String>[];
  List<String> vendorsId = <String>[];
  List<String> vendorlist = <String>[];

  getVendorData() async {
    var vend = await ApiClient().getVendorList();
    // debugPrint(vend.toString());
    // print(vend[1]["username"]);
    // vendors = [
    //   for (var items in vend) items["username"],
    // ];
    vendors = <String>[
      for (var items in vend) items["username"],
    ];

    vendorsId = <String>[
      for (var items in vend) items["id"].toString(),
    ];

    vendorlist = [
      for (var items in vend) '${items["id"].toString()}, ${items["username"]}',
    ];

    debugPrint(vendors.toString());
    debugPrint(vendorsId.toString());
    debugPrint(vendorlist.toString());
    return "success";
  }

  @override
  void initState() {
    getCurrentUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    buildVendorForm(),
                    const SizedBox(
                      height: 15,
                    ),
                    buildOrnamentForm(),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildModal1(),
                        buildModal2(),
                        buildProdVideo(),
                        buildProd1(),
                        buildProd2(),
                        buildProd3(),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(content: Text('Processing Data')),
                            // );
                            setState(() {
                              _isLoading = true;
                            });
                            submitForm2();
                            // FutureBuilder(
                            //     future: submitForm2(),
                            //     builder: (context, snapshot) {
                            //       if (snapshot.hasData) {
                            //         setState(() {
                            //           _isLoading = false;
                            //         });
                            //         return Container();
                            //       }
                            //       return Container();
                            //     });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Form Invalid, Please check.')),
                            );
                          }
                        },
                        child: Text((progress == "") ? "Send Data" : progress),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          // clearImage();
                          // ApiClient().getVendorList();
                          // getCurrentUserId();
                          debugPrint(_selectedVendor.toString());
                        },
                        child: const Text("Test")),
                    const SizedBox(
                      height: 15,
                    ),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       loadTest();
                    //     },
                    //     child: const Text("Test")),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       debugPrint("Clearing Sharedpref for Gold rate");
                    //       clearPrefs();
                    //     },
                    //     child: const Text("Clear")),
                  ],
                ),
              ),
            ),
          );
  }

  Column buildProd1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 12.0, bottom: 8.0, top: 12.0),
          child: SizedBox(
            child: Text(
              "Product Pic 1",
              textAlign: TextAlign.start,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey,
              )),
          child: Row(
            children: [
              SizedBox(
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      loadProdPic1();
                    },
                    child: const Text("Choose File"),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  getTextImg(prodPic1),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (prodPic1 != null)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      prodPic1 = null;
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Icon(
                      Icons.highlight_remove_outlined,
                      color: Colors.blue,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Column buildProd2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 12.0, bottom: 8.0, top: 12.0),
          child: SizedBox(
            child: Text(
              "Product Pic 2",
              textAlign: TextAlign.start,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey,
              )),
          child: Row(
            children: [
              SizedBox(
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      loadProdPic2();
                    },
                    child: const Text("Choose File"),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  getTextImg(prodPic2),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (prodPic2 != null)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      prodPic2 = null;
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Icon(
                      Icons.highlight_remove_outlined,
                      color: Colors.blue,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Column buildProd3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 12.0, bottom: 8.0, top: 12.0),
          child: SizedBox(
            child: Text(
              "Product Pic 3",
              textAlign: TextAlign.start,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey,
              )),
          child: Row(
            children: [
              SizedBox(
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      loadProdPic3();
                    },
                    child: const Text("Choose File"),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  getTextImg(prodPic3),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (prodPic3 != null)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      prodPic3 = null;
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Icon(
                      Icons.highlight_remove_outlined,
                      color: Colors.blue,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Column buildProdVideo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 12.0, bottom: 8.0, top: 12.0),
          child: SizedBox(
            child: Text(
              "Product Video",
              textAlign: TextAlign.start,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey,
              )),
          child: Row(
            children: [
              SizedBox(
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      loadProdVideo();
                    },
                    child: const Text("Choose File"),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  getTextImg(prodVideo),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (prodVideo != null)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      prodVideo = null;
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Icon(
                      Icons.highlight_remove_outlined,
                      color: Colors.blue,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Column buildModal1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 12.0, bottom: 8.0, top: 12.0),
          child: SizedBox(
            child: Text(
              "Modal Pic 1",
              textAlign: TextAlign.start,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey,
              )),
          child: Row(
            children: [
              SizedBox(
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      loadModal1();
                    },
                    child: const Text("Choose File"),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  getTextImg(modalPic1),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (modalPic1 != null)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      modalPic1 = null;
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Icon(
                      Icons.highlight_remove_outlined,
                      color: Colors.blue,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Column buildModal2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 12.0, bottom: 8.0, top: 12.0),
          child: SizedBox(
            child: Text(
              "Modal Pic 2",
              textAlign: TextAlign.start,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey,
              )),
          child: Row(
            children: [
              SizedBox(
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      loadModal2();
                    },
                    child: const Text("Choose File"),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  getTextImg(modalPic2),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (modalPic2 != null)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      modalPic2 = null;
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Icon(
                      Icons.highlight_remove_outlined,
                      color: Colors.blue,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Column buildVendorForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 60,
          child: InputDecorator(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Select Vendor",
            ),
            child: FutureBuilder(
                future: getVendorData(),
                builder: (context, snapshot) {
                  return DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: _selectedVendor,
                      hint: const Text("Select Vendor"),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedVendor = value ?? "";
                        });
                      },
                      items: vendorlist
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value.split(", ")[1]),
                        );
                      }).toList(),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }

  Column buildOrnamentForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 60,
          child: InputDecorator(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Select Ornament",
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: _selectedOrnament,
                hint: const Text("Select Ornament"),
                onChanged: (String? value) {
                  setState(() {
                    _selectedOrnament = value ?? "";
                  });
                },
                items: ornaments.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
