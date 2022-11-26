import 'dart:convert';

import '../constant/navbar.dart';
import '../constant/vars.dart';
import '../core/api_client.dart';
import 'package:flutter/material.dart';
import '../constant/vars.dart' as vars;
import '../constant/urls.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../widgets/form_dropdown.dart';
import '../widgets/form_static_text.dart';
import '../widgets/form_text.dart';

class AddProduct4 extends StatelessWidget {
  const AddProduct4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColorOld().background(),
      drawer: const NavDraw(),
      appBar: AppBar(
        title: Text(
          "Add Product",
          style: TextStyle(color: MyColorOld().icon2()),
        ),
      ),
      body: const FormWidget(),
    );
  }
}

class DropdownValue {
  String _days = "";
  String _metal = "";
  String _ornament = "";

  String get days => _days;
  String get metal => _metal;
  String get ornament => _ornament;

  void setDay(val) {
    _days = val;
  }

  void setMetal(val) {
    _metal = val;
  }

  void setOrnament(val) {
    _ornament = val;
  }
}

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  // final selectDay = GlobalKey<FormFieldState>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _purityController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _grossWeightController = TextEditingController();
  final TextEditingController _stoneWeightController = TextEditingController();
  final TextEditingController _makingChargeController = TextEditingController();
  final TextEditingController _wastageChargeController =
      TextEditingController();
  final TextEditingController _stoneChargeController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  DropdownValue dropDownObj = DropdownValue();
  // String? _selectedMetal;
  // String? _selectedOrnament;
  // String? _selectedDay;
  String _selectedPhotoId = "";
  String _selectedPhotoUrl = "";

  int _netWeightValue = 0;
  int _netAmountValue = 0;
  double _makingAmount = 0;
  double _wastageAmount = 0;
  double _totalAmountValue = 0;
  String status = "Pending";

  @override
  void dispose() {
    _purityController.dispose();
    _rateController.dispose();
    _grossWeightController.dispose();
    _stoneWeightController.dispose();
    _makingChargeController.dispose();
    _wastageChargeController.dispose();
    _stoneChargeController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  double paddingHeight = 20.0;

  void showAction(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text("Please add gold rate first"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/addGold');
              },
              child: const Text('Okay'),
            ),
          ],
        );
      },
    );
  }

  getRate() async {
    return "5000";
  }

  var mydata;
  // List mydataFiltered = [];
  getPhotographerImages() async {
    List currentUserId = await getUser();
    String spacelessOrnament = dropDownObj._ornament.replaceAll(" ", "_");
    final uri =
        Uri.http(urlMain, '/pics/$spacelessOrnament/${currentUserId[1]}/');
    final headers = {'Content-Type': 'application/json'};
    final response = await http.get(uri, headers: headers);
    mydata = await jsonDecode(response.body);
    debugPrint("GetPhotoImages: $mydata");
    debugPrint("GetPhotoImages Length: ${mydata.length}");

    // mydataFiltered = [];
    // for (var d in mydata) {
    //   debugPrint("AddProd4: for loop mydata > $d");
    //   debugPrint("AddProd4: for loop mydata vendor_id > ${d["vendor_id"]}");
    //   debugPrint("AddProd4: for loop mydata status > ${d["status"]}");
    //   if (d["status"] == "Approved") {
    //     mydataFiltered.insert(0, d);
    //   }
    // }

    if (response.statusCode.toString()[0] == "2") {
      return "success";
    } else {
      return null;
    }
  }

  var totalweight;
  var totalNetAmt;
  void _calculate() {
    int rate = int.tryParse(_rateController.text) ?? 0;
    int grossweight = int.tryParse(_grossWeightController.text) ?? 0;
    int stoneweight = int.tryParse(_stoneWeightController.text) ?? 0;
    totalweight = grossweight - stoneweight;
    totalNetAmt = totalweight * rate;
    int makingCharge = int.tryParse(_makingChargeController.text) ?? 0;
    int wastageCharge = int.tryParse(_wastageChargeController.text) ?? 0;
    num makingAmount = (makingCharge / 100) * totalNetAmt;
    num wastageAmount = (wastageCharge / 100) * totalNetAmt;
    int stoneCharge = int.tryParse(_stoneChargeController.text) ?? 0;
    setState(() {
      _netWeightValue = totalweight;
      _netAmountValue = totalNetAmt;
      _makingAmount = makingAmount.toDouble();
      _wastageAmount = wastageAmount.toDouble();
      _totalAmountValue =
          _netAmountValue + _makingAmount + _wastageAmount + stoneCharge;
    });
  }

  getUser() async {
    final prefs = await SharedPreferences.getInstance();
    List? userkey = prefs.getStringList('userkey');
    debugPrint("AddProd4: Username > ${userkey![2]}");
    debugPrint("AddProd4: User id > ${userkey[0]}");
    return [userkey[2], userkey[0]];
  }

  submitForm() async {
    if (_selectedPhotoId == "") {
      selectImageDialog();
      return;
    }
    debugPrint("AddProd4: submitform > Posting");
    List user = await getUser();
    Map<String, String> body = {
      "product_name": _productNameController.text,
      "metal": dropDownObj._metal,
      "ornament": dropDownObj._ornament,
      "purity": _purityController.text,
      "rate": _rateController.text,
      "grossw": _grossWeightController.text,
      "stonew": _stoneWeightController.text,
      "makingc": _makingChargeController.text,
      "makingcamt": _makingAmount.toString(),
      "wastagec": _wastageChargeController.text,
      "wastagecamt": _wastageAmount.toString(),
      "stonec": _stoneChargeController.text,
      "netw": totalweight.toString(),
      "neta": totalNetAmt.toString(),
      "totala": _totalAmountValue.toString(),
      "vaildd": dropDownObj._days,
      "qty": _quantityController.text,
      "vendor": user[0],
      "vendor_id": user[1].toString(),
      "submitdate": vars.date.toString(),
      "image": _selectedPhotoId.toString(),
      "status": status,
    };
    debugPrint("Prod4: submitform > $body");
    Uri url = Uri.parse(urlNoti);
    http.Response response = await ApiClient().postJson(url, jsonEncode(body));
    debugPrint("Prod4: submitform response > ${jsonDecode(response.body)}");

    // Mark Assigned to Photographers Pic
    if (response.statusCode.toString()[0] == "2") {
      String body2 = jsonEncode({"status": "Assigned"});
      http.Response response2 = await ApiClient()
          .patchJson("http://$urlMain/pics/$_selectedPhotoId/", body2);
      debugPrint("AddProd4: Pic Assigned statuscode > ${response2.statusCode}");
      if (response2.statusCode.toString()[0] == "2") {
        successDialog();
      } else {
        debugPrint("An Error Occured");
        debugPrint("AddProd4: submitForm > response: ${response.body}");
        debugPrint("AddProd4: submitForm > response2: ${response2.body}");
        errorDialog();
      }
    }
  }

  Future<dynamic> selectImageDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Please select an Image"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Okay"))
            ],
          );
        });
  }

  Future<dynamic> errorDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Failed"),
            content: const Text("Product submission failed"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Back"))
            ],
          );
        });
  }

  Future<dynamic> successDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Success"),
            content: const Text("Product submitted successfully"),
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _rateController.addListener(_calculate);
    _stoneWeightController.addListener(_calculate);
    _grossWeightController.addListener(_calculate);
    _makingChargeController.addListener(_calculate);
    _wastageChargeController.addListener(_calculate);
    _stoneChargeController.addListener(_calculate);
  }

  // @override
  // Widget build(BuildContext context) {
  //   return SingleChildScrollView(
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: FutureBuilder(
  //           future: getRate(),
  //           builder: (context, snapshot) {
  //             if (snapshot.data == null) {
  //               return SizedBox(
  //                 height: 680,
  //                 child: Center(
  //                   child: AlertDialog(
  //                     content: const Text("Please add gold rate first"),
  //                     actions: [
  //                       TextButton(
  //                         onPressed: () {
  //                           Navigator.of(context).pop();
  //                           Navigator.pushNamed(context, '/addGold');
  //                         },
  //                         child: const Text('Okay'),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             }
  //             return formWidget(context);
  //           }),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: formWidget(context),
      ),
    );
  }

  Form formWidget(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: paddingHeight),
            MyTextFormField(
              name: "Product Name",
              controller: _productNameController,
              txtType: TextInputType.text,
            ),
            SizedBox(height: paddingHeight),
            MyDropdownField(
              name: "Select Metal",
              valueList: vars.metalType,
              obj: dropDownObj,
              setType: 'metal',
            ),
            SizedBox(height: paddingHeight),
            MyDropdownField(
              name: "Select Ornament",
              valueList: vars.ornaments,
              obj: dropDownObj,
              setType: 'ornament',
            ),
            SizedBox(height: paddingHeight),
            MyTextFormField(
              name: "Purity %",
              controller: _purityController,
              txtType: TextInputType.number,
            ),
            SizedBox(height: paddingHeight),
            MyTextFormField(
              name: "Rate",
              controller: _rateController,
              txtType: TextInputType.number,
            ),
            SizedBox(height: paddingHeight),
            MyTextFormField(
              name: "Gross Weight",
              controller: _grossWeightController,
              txtType: TextInputType.number,
            ),
            SizedBox(height: paddingHeight),
            MyTextFormField(
              name: "Stone Weight",
              controller: _stoneWeightController,
              txtType: TextInputType.number,
            ),
            SizedBox(height: paddingHeight),
            // MyTextFormField(
            //     name: "Net Weight", controller: _netWeightController),
            StaticFormField(
              title: 'Net Weight',
              value: _netWeightValue.toString(),
            ),
            SizedBox(height: paddingHeight),
            StaticFormField(
              title: 'Net Amount',
              value: _netAmountValue.toString(),
            ),
            SizedBox(height: paddingHeight),
            MyTextFormField(
              name: "Making Charge %",
              controller: _makingChargeController,
              txtType: TextInputType.number,
            ),
            SizedBox(height: paddingHeight),
            MyTextFormField(
              name: "Wastage Charge %",
              controller: _wastageChargeController,
              txtType: TextInputType.number,
            ),
            SizedBox(height: paddingHeight),
            MyTextFormField(
              name: "Stone Charge",
              controller: _stoneChargeController,
              txtType: TextInputType.number,
            ),
            SizedBox(height: paddingHeight),
            // MyTextFormField(
            //     name: "Total Amount", controller: _totalAmountController),
            StaticFormField(
              title: 'Total Amount',
              value: _totalAmountValue.toString(),
            ),
            SizedBox(height: paddingHeight),

            MyDropdownField(
              name: "Select Day",
              valueList: vars.validDate,
              obj: dropDownObj,
              setType: 'day',
            ),
            SizedBox(height: paddingHeight),
            MyTextFormField(
              name: "Quantity",
              controller: _quantityController,
              txtType: TextInputType.number,
            ),
            SizedBox(height: paddingHeight),
            selectPhoto(),
            SizedBox(height: paddingHeight),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: MyColorOld().icon2()),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text('Processing Data')),
                    // );
                    submitForm();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Form Invalid, Please check.')),
                    );
                  }
                },
                child: const Text(
                  "Send Data",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 50),
            // ElevatedButton(
            //     onPressed: () {
            //       debugPrint(_productNameController.text);
            //       debugPrint(dropDownObj._metal);
            //       debugPrint(dropDownObj._ornament);
            //       debugPrint(_purityController.text);
            //       debugPrint(_rateController.text);
            //       debugPrint(_grossWeightController.text);
            //       debugPrint(_stoneWeightController.text);
            //       debugPrint(_netWeightValue.toString());
            //       debugPrint(_netAmountValue.toString());
            //       debugPrint(_makingChargeController.text);
            //       debugPrint(_wastageChargeController.text);
            //       debugPrint(_stoneChargeController.text);
            //       debugPrint(_totalAmountValue.toString());
            //       debugPrint(dropDownObj._days);
            //       debugPrint(_quantityController.text);
            //     },
            //     child: const Text("Test")),
          ],
        ));
  }

  Column selectPhoto() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 12.0, bottom: 8.0, top: 12.0),
          child: SizedBox(
            child: Text(
              "Select Photographer's Ornament",
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
                      if (dropDownObj._ornament != "") {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return FutureBuilder(
                                  future: getPhotographerImages(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return mydata.isEmpty
                                          ? const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Center(
                                                  child: Text(
                                                'No images found, Please request photographer to upload images.',
                                                style: TextStyle(
                                                  color: Colors.amber,
                                                  shadows: [
                                                    Shadow(
                                                        offset:
                                                            Offset(2.0, 2.0),
                                                        blurRadius: 8.0,
                                                        color: Colors.red)
                                                  ],
                                                ),
                                              )),
                                            )
                                          : ListView.builder(
                                              itemCount: mydata.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                debugPrint(
                                                    "future built get photos : $mydata");

                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      _selectedPhotoId =
                                                          mydata[0]["id"]
                                                              .toString();
                                                      _selectedPhotoUrl =
                                                          mydata[index]
                                                              ["model1"];
                                                      setState(() {});
                                                      Navigator.pop(context);
                                                    },
                                                    child: Card(
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                              "Product id #${mydata[index]["id"]}"),
                                                          Text(
                                                              "For: Vendor #${mydata[index]["vendor"]}"),
                                                          Text(
                                                              "By: Photographer #${mydata[index]["photographer_id"]}"),
                                                          Text(
                                                              "Status: ${mydata[index]["status"]}"),
                                                          Text(
                                                              "Date: ${mydata[index]["date"]}"),
                                                          SizedBox(
                                                            height: 200,
                                                            width: 200,
                                                            child: PhotoView(
                                                              imageProvider:
                                                                  NetworkImage(mydata[
                                                                          index]
                                                                      [
                                                                      "model1"]),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              });
                                    }

                                    return const Center(
                                        child: CircularProgressIndicator());
                                  });
                            });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MyColorOld().icon2()),
                    child: const Text(
                      "Choose File",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: (_selectedPhotoId == "")
                    ? const Text(
                        "Select an Image",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    : Stack(alignment: Alignment.topRight, children: [
                        SizedBox(
                            height: 200,
                            width: 200,
                            child: PhotoView(
                              imageProvider: NetworkImage(_selectedPhotoUrl),
                            )),
                        GestureDetector(
                          onTap: () {
                            _selectedPhotoId = "";
                            setState(() {});
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.grey[850]),
                              child: const Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Icon(Icons.close),
                              )),
                        )
                      ]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
