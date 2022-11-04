import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'navbar.dart';

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
      body: const GoldRateWidget(),
    );
  }
}

const List<String> vendors = <String>['Attica Gold', 'Minam Solutions'];
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

class GoldRateWidget extends StatefulWidget {
  const GoldRateWidget({super.key});

  @override
  State<GoldRateWidget> createState() => _GoldRateWidgetState();
}

class _GoldRateWidgetState extends State<GoldRateWidget> {
  String? _selectedVendor;
  String? _selectedOrnament;
  final _formKey = GlobalKey<FormState>();
  XFile? modalPic1;
  XFile? modalPic2;
  XFile? prodVideo;
  XFile? prodPic1;
  // FilePickerResult? prodPic1;
  XFile? prodPic2;
  XFile? prodPic3;

  submitForm(context) async {
    List<String> myList = [
      _selectedVendor ?? "",
      _selectedOrnament ?? "",
      time,
      date,
    ];

    if (_selectedVendor != "" &&
        _selectedOrnament != "" &&
        modalPic1 != null &&
        modalPic2 != null &&
        prodVideo != null &&
        prodPic1 != null &&
        prodPic2 != null &&
        prodPic3 != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('last_image', myList);

      var savepath;
      String ext;

      ext = prodPic1!.name.split(".")[1];
      savepath = await getFilePath("ProdPic1", ext);
      prodPic1!.saveTo(savepath);

      ext = prodPic2!.name.split(".")[1];
      savepath = await getFilePath("ProdPic2", ext);
      prodPic2!.saveTo(savepath);

      ext = prodPic3!.name.split(".")[1];
      savepath = await getFilePath("ProdPic3", ext);
      prodPic3!.saveTo(savepath);

      ext = prodVideo!.name.split(".")[1];
      savepath = await getFilePath("ProdVideo", ext);
      prodVideo!.saveTo(savepath);

      ext = modalPic1!.name.split(".")[1];
      savepath = await getFilePath("ModalPic1", ext);
      modalPic1!.saveTo(savepath);

      ext = modalPic2!.name.split(".")[1];
      savepath = await getFilePath("ModalPic2", ext);
      modalPic2!.saveTo(savepath);

      // postApiHere

      _showAction(context, "Data submitted successfully");
      _selectedVendor = null;
      _selectedOrnament = null;
      prodPic1 = null;
      prodPic2 = null;
      prodPic3 = null;
      prodVideo = null;
      modalPic1 = null;
      modalPic2 = null;
      setState(() {});
    } else {
      debugPrint("Please fill all required labels");
      _showAction(context, "Please fill all required labels");
    }
  }

  void _showAction(BuildContext context, myText) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(myText),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  clearPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('last_rate');
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

    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      submitForm(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Form Invalid, Please check.')),
                      );
                    }
                  },
                  child: const Text("Send Data"),
                ),
              ),
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
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: _selectedVendor,
                hint: const Text("Select Vendor"),
                onChanged: (String? value) {
                  setState(() {
                    _selectedVendor = value ?? "";
                  });
                },
                items: vendors.map<DropdownMenuItem<String>>((String value) {
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
