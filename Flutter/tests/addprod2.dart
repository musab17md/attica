import 'dart:convert';

import '../constant/navbar.dart';
import '../core/api_client.dart';
import 'package:flutter/material.dart';

class AddProduct2 extends StatefulWidget {
  const AddProduct2({Key? key}) : super(key: key);

  @override
  State<AddProduct2> createState() => _AddProduct2State();
}

class _AddProduct2State extends State<AddProduct2> {
  // void updateNetWeight(){
  //   setState(() {
  //     int value = (int.tryParse(formValue[4]) ?? 0) - (int.tryParse(formValue[5]) ?? 0);
  //     netWValue = value.toString();
  //     formValue[9] = netWValue;
  //     debugPrint(netWValue);
  //   });
  // }
  //
  // void updateNetAmount(){
  //   setState(() {
  //     int value = (int.tryParse(formValue[3]) ?? 0) * (int.tryParse(formValue[9]) ?? 0);
  //     debugPrint("${formValue[3]} x ${formValue[9]}");
  //     netAValue = value.toString();
  //     formValue[10] = netAValue;
  //     debugPrint(netAValue);
  //   });
  // }
  //
  // void updateTotalAmount(){
  //   setState(() {
  //     int value = (int.tryParse(formValue[6]) ?? 0) + (int.tryParse(formValue[7]) ?? 0) + (int.tryParse(formValue[8]) ?? 0) + (int.tryParse(formValue[10]) ?? 0);
  //     debugPrint("${formValue[6]} + ${formValue[7]} + ${formValue[8]} + ${formValue[10]}");
  //     totalAValue = value.toString();
  //     formValue[11] = totalAValue;
  //     debugPrint(totalAValue);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDraw(),
      appBar: AppBar(
        title: const Text("Add Product Details 2"),
      ),
      body: const FormWidget(),
    );
  }
}

class FormWidget extends StatefulWidget {
  const FormWidget({Key? key}) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  List<String> formValue = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
  ];
  String netWValue = "0";
  String netAValue = "0";
  String totalAValue = "0";
  double paddingHeight = 20.0;

  multiplyNetAmount(val) {
    debugPrint(val.runtimeType.toString());
    var a = int.tryParse(formValue[10]) ?? 0;
    var b = int.tryParse(val) ?? 0;
    debugPrint("($a / 100) x $b");
    return (a / 100) * b;
  }

  updateAll() {
    setState(() {
      int value1 =
          (int.tryParse(formValue[4]) ?? 0) - (int.tryParse(formValue[5]) ?? 0);
      netWValue = value1.toString();
      formValue[9] = netWValue;
      debugPrint(netWValue);

      int value2 =
          (int.tryParse(formValue[3]) ?? 0) * (int.tryParse(formValue[9]) ?? 0);
      debugPrint("${formValue[3]} x ${formValue[9]}");
      netAValue = value2.toString();
      formValue[10] = netAValue;
      debugPrint(netAValue);

      double a = double.tryParse(formValue[6]) ?? 0;
      double b = double.tryParse(formValue[7]) ?? 0;
      double value3 = a +
          b +
          (int.tryParse(formValue[8]) ?? 0) +
          (int.tryParse(formValue[10]) ?? 0);
      debugPrint(
          "${formValue[6]} + ${formValue[7]} + ${formValue[8]} + ${formValue[10]}");
      totalAValue = value3.toString();
      formValue[11] = totalAValue;
      debugPrint(totalAValue);
    });
  }

  Future createProduct(BuildContext context, response) async {
    if ((response.statusCode ~/ 100) == 2) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Success"),
              content: const Text("Data submitted successfully."),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("List Data")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Add New")),
              ],
            );
          });
    } else {
      var jsonData = jsonDecode(response.body).toString();
      jsonData = jsonData
          .replaceAll(']', "\n\n")
          .replaceAll('[', "")
          .replaceAll('{', "")
          .replaceAll('}', "")
          .replaceAll(',', "")
          .replaceAll('\n ', "\n")
          .replaceAll('  ', " ");
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Failed"),
              content: Text(jsonData),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Close"))
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: paddingHeight),
          TextFormField(
            enableInteractiveSelection: false,
            decoration: const InputDecoration(
              label: Text("Metal"),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onChanged: (text) {
              formValue[0] = text;
              debugPrint(formValue.toString());
            },
          ),
          SizedBox(height: paddingHeight),
          TextFormField(
            enableInteractiveSelection: false,
            decoration: const InputDecoration(
              label: Text("Ornament"),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onChanged: (text) {
              formValue[1] = text;
              debugPrint(formValue.toString());
            },
          ),
          SizedBox(height: paddingHeight),
          TextFormField(
            enableInteractiveSelection: false,
            decoration: const InputDecoration(
              label: Text("Purity"),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onChanged: (text) {
              formValue[2] = text;
              debugPrint(formValue.toString());
            },
          ),
          SizedBox(height: paddingHeight),
          TextFormField(
            enableInteractiveSelection: false,
            decoration: const InputDecoration(
              label: Text("Rate"),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onChanged: (text) {
              formValue[3] = text;
              updateAll();
              debugPrint(formValue.toString());
            },
          ),
          SizedBox(height: paddingHeight),
          TextFormField(
            enableInteractiveSelection: false,
            decoration: const InputDecoration(
              label: Text("Gross Weight"),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onChanged: (text) {
              formValue[4] = text;
              updateAll();
              debugPrint(formValue.toString());
            },
          ),
          SizedBox(height: paddingHeight),
          TextFormField(
            enableInteractiveSelection: false,
            decoration: const InputDecoration(
              label: Text("Stone Weight"),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onChanged: (text) {
              formValue[5] = text;
              updateAll();
              debugPrint(formValue.toString());
            },
          ),
          SizedBox(height: paddingHeight),
          TextFormField(
            enableInteractiveSelection: false,
            decoration: const InputDecoration(
              label: Text("Making Charge %"),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onChanged: (text) {
              formValue[6] = multiplyNetAmount(text).toString();
              updateAll();
              debugPrint(formValue.toString());
            },
          ),
          SizedBox(height: paddingHeight),
          TextFormField(
            enableInteractiveSelection: false,
            decoration: const InputDecoration(
              label: Text("Wastage Charge %"),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onChanged: (text) {
              formValue[7] = multiplyNetAmount(text).toString();
              updateAll();
              debugPrint(formValue.toString());
            },
          ),
          SizedBox(height: paddingHeight),
          TextFormField(
            enableInteractiveSelection: false,
            decoration: const InputDecoration(
              label: Text("Stone Charge"),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onChanged: (text) {
              formValue[8] = text;
              updateAll();
              debugPrint(formValue.toString());
            },
          ),
          SizedBox(height: paddingHeight),
          TextFormField(
            readOnly: true,
            key: Key(netWValue.toString()),
            initialValue: netWValue,
            enableInteractiveSelection: false,
            decoration: const InputDecoration(
              label: Text("Net Weight"),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: paddingHeight),
          TextFormField(
            readOnly: true,
            key: Key(netAValue.toString()),
            initialValue: netAValue,
            enableInteractiveSelection: false,
            decoration: const InputDecoration(
              label: Text("Net Amount"),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: paddingHeight),
          TextFormField(
            readOnly: true,
            key: Key(totalAValue.toString()),
            initialValue: totalAValue,
            enableInteractiveSelection: false,
            decoration: const InputDecoration(
              label: Text("Total Amount"),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: paddingHeight),
          TextFormField(
            enableInteractiveSelection: false,
            decoration: const InputDecoration(
              label: Text("Valid D"),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onChanged: (text) {
              formValue[12] = text;
              debugPrint(formValue.toString());
            },
          ),
          SizedBox(height: paddingHeight),
          TextFormField(
            enableInteractiveSelection: false,
            decoration: const InputDecoration(
              label: Text("Quantity"),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onChanged: (text) {
              formValue[13] = text;
              debugPrint(formValue.toString());
            },
          ),
          SizedBox(height: paddingHeight),
          TextFormField(
            enableInteractiveSelection: false,
            decoration: const InputDecoration(
              label: Text("Vendor"),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onChanged: (text) {
              formValue[14] = text;
              debugPrint(formValue.toString());
            },
          ),
          SizedBox(height: paddingHeight),
          TextFormField(
            enableInteractiveSelection: false,
            decoration: const InputDecoration(
              label: Text("Submit Date"),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onChanged: (text) {
              formValue[15] = text;
              debugPrint(formValue.toString());
            },
          ),
          SizedBox(height: paddingHeight),
          TextFormField(
            enableInteractiveSelection: false,
            decoration: const InputDecoration(
              label: Text("Image"),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onChanged: (text) {
              formValue[16] = text;
              debugPrint(formValue.toString());
            },
          ),
          SizedBox(height: paddingHeight),
          TextFormField(
            enableInteractiveSelection: false,
            decoration: const InputDecoration(
              label: Text("Status"),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onChanged: (text) {
              formValue[17] = text;
              debugPrint(formValue.toString());
            },
          ),
          ElevatedButton(
            onPressed: () {
              List myList = [
                formValue[0],
                formValue[1],
                formValue[2],
                formValue[3],
                formValue[4],
                formValue[5],
                formValue[6],
                formValue[7],
                formValue[8],
                formValue[9],
                formValue[10],
                formValue[11],
                formValue[12],
                formValue[13],
                formValue[14],
                formValue[15],
                formValue[16],
                formValue[17]
              ];
              ApiClient().postData(myList).then((value) {
                debugPrint(value.toString());
                debugPrint("value.toString()");
                createProduct(context, value);
              });
            },
            child: const Text("Send Data"),
          ),
        ],
      ),
    );
  }
}
