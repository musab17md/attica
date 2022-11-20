import 'dart:convert';

import 'package:attica/constant/navbar.dart';
import 'package:attica/core/api_client.dart';
import 'package:flutter/material.dart';
import 'package:attica/constant/vars.dart' as vars;
import 'package:http/http.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/urls.dart';
import 'package:http/http.dart' as http;

import '../constant/vars.dart';

class AddProduct4 extends StatelessWidget {
  const AddProduct4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDraw(),
      appBar: AppBar(
        title: const Text("Add Product"),
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
  getPhotographerImages() async {
    String spacelessOrnament = dropDownObj._ornament.replaceAll(" ", "_");
    final uri = Uri.http(urlMain, '/pics/$spacelessOrnament/');
    final headers = {'Content-Type': 'application/json'};
    final response = await http.get(uri, headers: headers);
    debugPrint(response.body);
    mydata = jsonDecode(response.body);
    return mydata;
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
      "submitdate": date.toString(),
      "image": _selectedPhotoId.toString(),
      "status": status,
    };
    debugPrint(body.toString());
    Uri url = Uri.parse(urlNoti);
    Response response = await ApiClient().postJson(url, jsonEncode(body));
    debugPrint(jsonDecode(response.body).toString());
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: getRate(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return SizedBox(
                  height: 680,
                  child: Center(
                    child: AlertDialog(
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
                    ),
                  ),
                );
              }
              return formWidget(context);
            }),
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
                name: "Product Name", controller: _productNameController),
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
            MyTextFormField(name: "Purity %", controller: _purityController),
            SizedBox(height: paddingHeight),
            MyTextFormField(name: "Rate", controller: _rateController),
            SizedBox(height: paddingHeight),
            MyTextFormField(
                name: "Gross Weight", controller: _grossWeightController),
            SizedBox(height: paddingHeight),
            MyTextFormField(
                name: "Stone Weight", controller: _stoneWeightController),
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
                name: "Making Charge %", controller: _makingChargeController),
            SizedBox(height: paddingHeight),
            MyTextFormField(
                name: "Wastage Charge %", controller: _wastageChargeController),
            SizedBox(height: paddingHeight),
            MyTextFormField(
                name: "Stone Charge", controller: _stoneChargeController),
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
            MyTextFormField(name: "Quantity", controller: _quantityController),
            SizedBox(height: paddingHeight),
            selectPhoto(),
            SizedBox(height: paddingHeight),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    submitForm();
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
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: () {
                  debugPrint(_productNameController.text);
                  debugPrint(dropDownObj._metal);
                  debugPrint(dropDownObj._ornament);
                  debugPrint(_purityController.text);
                  debugPrint(_rateController.text);
                  debugPrint(_grossWeightController.text);
                  debugPrint(_stoneWeightController.text);
                  debugPrint(_netWeightValue.toString());
                  debugPrint(_netAmountValue.toString());
                  debugPrint(_makingChargeController.text);
                  debugPrint(_wastageChargeController.text);
                  debugPrint(_stoneChargeController.text);
                  debugPrint(_totalAmountValue.toString());
                  debugPrint(dropDownObj._days);
                  debugPrint(_quantityController.text);
                },
                child: const Text("Test")),
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
                        getPhotographerImages();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return FutureBuilder(
                                  future: getPhotographerImages(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return ListView.builder(
                                          itemCount: mydata == null
                                              ? 0
                                              : mydata?.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            debugPrint(mydata.toString());
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  _selectedPhotoId = mydata[0]
                                                          ["id"]
                                                      .toString();
                                                  _selectedPhotoUrl =
                                                      mydata[0]["model1"];
                                                  setState(() {});
                                                  Navigator.pop(context);
                                                },
                                                child: Card(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                          "By: ${mydata[0]["vendor"]}"),
                                                      Text(
                                                          "Date: ${mydata[0]["date"]}"),
                                                      SizedBox(
                                                        height: 200,
                                                        width: 200,
                                                        child: PhotoView(
                                                          imageProvider:
                                                              NetworkImage(
                                                                  mydata[0][
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
                    child: const Text("Choose File"),
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

class MyTextFormField extends StatelessWidget {
  final String name;
  final TextEditingController controller;

  const MyTextFormField(
      {super.key, required this.name, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        label: Text(name),
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}

class StaticFormField extends StatelessWidget {
  const StaticFormField({super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child: Text(value),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 2.0),
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MyDropdownField extends StatefulWidget {
  final String name;
  final List<String> valueList;
  DropdownValue obj;
  final String setType;
  MyDropdownField(
      {super.key,
      required this.name,
      required this.valueList,
      required this.obj,
      required this.setType});

  @override
  State<MyDropdownField> createState() => _MyDropdownFieldState();
}

class _MyDropdownFieldState extends State<MyDropdownField> {
  final dropdownState = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DropdownButtonFormField(
        key: dropdownState,
        hint: Text(widget.name),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        items: widget.valueList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          if (widget.setType == "day") {
            widget.obj.setDay(value);
          }
          if (widget.setType == "metal") {
            widget.obj.setMetal(value);
          }
          if (widget.setType == "ornament") {
            widget.obj.setOrnament(value);
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}
