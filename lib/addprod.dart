import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'navbar.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

const List<String> metalType = <String>['', 'Gold', 'Silver', 'Three', 'Four'];
const List<String> ornaments = <String>[
  "",
  "tikkas",
  "earrings",
  "anklets",
  "bangles",
  "rings",
  "necklaces",
  "pendants",
  "toe rings",
  "bracelets",
  "nose pins"
];

class _AddProductState extends State<AddProduct> {
  String metalValue = metalType.first;
  String ornamentValue = ornaments.first;
  String purityValue = "";
  var token = '68c2a7cc5e09dd2a179438f50d1fd0350096b08b';

  Future createProduct(BuildContext context) async {

    var response = await http.post(
      Uri.parse('http://192.168.0.134:8080/api_acc/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      },
      body: jsonEncode({
        'select_metal': metalValue,
        'ornament_type': ornamentValue,
        'purity': purityValue
      }),
    );

    debugPrint("Post req done");
    debugPrint(response.statusCode.toString());
    debugPrint(response.body.toString());

    if ((response.statusCode ~/ 100) == 2){
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
      jsonData = jsonData.replaceAll(']', "\n\n").replaceAll('[', "").replaceAll('{', "").replaceAll('}', "").replaceAll(',', "").replaceAll('\n ', "\n").replaceAll('  ', " ");
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
    return Scaffold(
      drawer: const NavDraw(),
      appBar: AppBar(
        title: const Text("Add Product Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildSelectMetalForm(),
            const SizedBox(height: 10),
            buildOrnamentTypeForm(),
            const SizedBox(height: 10),
            buildPurityForm(),
            const SizedBox(height: 10),
            buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Column buildSelectMetalForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Metal',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        InputDecorator(
          decoration: const InputDecoration(border: OutlineInputBorder()),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: metalValue,
              hint: const Text("Select Metal"),
              onChanged: (value) {
                setState(() {
                  metalValue = value;
                });
              },
              items: metalType.map<DropdownMenuItem>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Column buildOrnamentTypeForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Ornament',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        InputDecorator(
          decoration: const InputDecoration(border: OutlineInputBorder()),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: ornamentValue,
              hint: const Text("Select Ornament"),
              onChanged: (value) {
                setState(() {
                  ornamentValue = value;
                });
              },
              items: ornaments.map<DropdownMenuItem>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Column buildPurityForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Purity",
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.percent),
          ),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          onChanged: (value) {
            purityValue = value;
          },
        ),
      ],
    );
  }

  ElevatedButton buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        debugPrint(metalValue);
        debugPrint(ornamentValue);
        debugPrint(purityValue);

        createProduct(context);

      },
      child: const Text("Submit"),
    );
  }

}

// Future createProduct(BuildContext context, token, metalValue, ornamentValue, purityValue) async {
//
//   var response = await http.post(
//     Uri.parse('http://192.168.0.134:8080/api_acc/'),
//     headers: {
//       'Content-Type': 'application/json',
//       'Authorization': 'Token $token',
//     },
//     body: jsonEncode({
//       'select_metal': metalValue,
//       'ornament_type': ornamentValue,
//       'purity': purityValue
//     }),
//   );
//
//   debugPrint("Post req done");
//   debugPrint(response.statusCode.toString());
//   debugPrint(response.body.toString());
//
//   showDialog(context: context, builder: (BuildContext context){
//     return AlertDialog(
//       title: const Text("Alert"),
//       content: Text(response.body.toString()),
//       actions: [
//         ElevatedButton(onPressed: (){
//           Navigator.pop(context);
//         }, child: const Text("Close"))
//       ],
//     );
//   });
// }
