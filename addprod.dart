import 'dart:convert';

import 'package:ecom/core/api_client.dart';
import 'package:ecom/provider/AddProductForm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  TextEditingController rateValue = TextEditingController();
  TextEditingController grossWValue = TextEditingController();
  TextEditingController stoneWValue = TextEditingController();
  TextEditingController makingCValue = TextEditingController();
  TextEditingController wastageCValue = TextEditingController();
  TextEditingController stoneCValue = TextEditingController();
  // TextEditingController netWValue = TextEditingController();
  int netWValue = 0;
  TextEditingController netAValue = TextEditingController();
  TextEditingController totalAValue = TextEditingController();
  TextEditingController validDValue = TextEditingController();
  TextEditingController qtyValue = TextEditingController();
  TextEditingController vendorValue = TextEditingController();
  TextEditingController submitDateValue = TextEditingController();
  TextEditingController imageValue = TextEditingController();
  TextEditingController statusValue = TextEditingController();

  var token = '68c2a7cc5e09dd2a179438f50d1fd0350096b08b';

  double paddingHeight = 20.0;

  void updateProvider(myContext){
    debugPrint("updateProvider");
    debugPrint(grossWValue.text);
    debugPrint(stoneWValue.text);
    myContext.read<UpdateNetAmount>().setGrossW(grossWValue.text);
    myContext.read<UpdateNetAmount>().setStoneW(stoneWValue.text);
  }

  Future createProduct(BuildContext context, response) async {

    // var response = await http.post(
    //   Uri.parse('http://192.168.0.134:8080/api_acc/'),
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'Authorization': 'Token $token',
    //   },
    //   body: jsonEncode({
    //     'select_metal': metalValue,
    //     'ornament_type': ornamentValue,
    //     'purity': purityValue
    //   }),
    // );
    //
    // debugPrint("Post req done");
    // debugPrint(response.statusCode.toString());
    // debugPrint(response.body.toString());

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
                      clearController();
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



  void clearController(){
    setState((){
      metalValue = metalType.first;
      ornamentValue = ornaments.first;
      purityValue = "";
    });
    rateValue.clear();
    grossWValue.clear();
    stoneWValue.clear();
    makingCValue.clear();
    wastageCValue.clear();
    stoneCValue.clear();
    // netWValue.clear();
    netAValue.clear();
    totalAValue.clear();
    validDValue.clear();
    qtyValue.clear();
    vendorValue.clear();
    submitDateValue.clear();
    imageValue.clear();
    statusValue.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        drawer: const NavDraw(),
        appBar: AppBar(
          title: const Text("Add Product Details"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              SizedBox(height: paddingHeight),
              buildSelectMetalForm(),
              SizedBox(height: paddingHeight),
              buildOrnamentTypeForm(),
              SizedBox(height: paddingHeight),
              buildPurityForm(),
              SizedBox(height: paddingHeight),
              TextFormWidget(myController: rateValue, name: "Rate Value", myContext:context),
              SizedBox(height: paddingHeight),
              TextFormWidget(myController: grossWValue, name: "Gross W", myContext:context),
              SizedBox(height: paddingHeight),
              TextFormWidget(myController: stoneWValue, name: "Stone W", myContext:context),
              SizedBox(height: paddingHeight),
              TextFormWidget(myController: makingCValue, name: "Making C", myContext:context),
              SizedBox(height: paddingHeight),
              TextFormWidget(myController: wastageCValue, name: "Wastage C", myContext:context),
              SizedBox(height: paddingHeight),
              TextFormWidget(myController: stoneCValue, name: "Stone C", myContext:context),
              SizedBox(height: paddingHeight),
              // TextFormWidget(myController: netWValue, name: "Net W"),
              Text('${context.watch<UpdateNetAmount>().netW}'.toString()),
              SizedBox(height: paddingHeight),
              TextFormWidget(myController: netAValue, name: "Net A", myContext:context),
              SizedBox(height: paddingHeight),
              TextFormWidget(myController: totalAValue, name: "Total A", myContext:context),
              SizedBox(height: paddingHeight),
              TextFormWidget(myController: validDValue, name: "Valid D", myContext:context),
              SizedBox(height: paddingHeight),
              TextFormWidget(myController: qtyValue, name: "Qty", myContext:context),
              SizedBox(height: paddingHeight),
              TextFormWidget(myController: vendorValue, name: "Vendor", myContext:context),
              SizedBox(height: paddingHeight),
              TextFormWidget(myController: submitDateValue, name: "Submit Date", myContext:context),
              SizedBox(height: paddingHeight),
              Row(
                children: [
                  const Text("Image:"),
                  ElevatedButton(onPressed: (){
                  }, child: const Text("Select Image"),),
                ],
              ),
              SizedBox(height: paddingHeight),
              TextFormWidget(myController: statusValue, name: "Stone W", myContext:context),
              SizedBox(height: paddingHeight),

              buildSubmitButton(),
              ElevatedButton(onPressed: (){
                List myList = [
                  metalValue,ornamentValue,purityValue,rateValue.text,grossWValue.text,stoneWValue.text,makingCValue.text,wastageCValue.text,stoneCValue.text,
                  netWValue.toString(),netAValue.text,totalAValue.text,validDValue.text,qtyValue.text,vendorValue.text,submitDateValue.text,imageValue.text,stoneWValue.text];
                ApiClient().postData(myList).then((value) {
                  debugPrint(value.toString());
                  debugPrint("value.toString()");
                  createProduct(context, value);
                });
              }, child: const Text("Send Data")),
              ElevatedButton(onPressed: (){
                clearController();
              }, child: const Text("Clear Data")),
              const SizedBox(height: 50),
            ],
          ),
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


        debugPrint(grossWValue.text);
        debugPrint(stoneWValue.text);

        // createProduct(context);

      },
      child: const Text("Print"),
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

class TextFormWidget extends StatefulWidget {
  final TextEditingController myController;
  final String name;
  final BuildContext myContext;
  const TextFormWidget({Key? key, required this.myController, required this.name, required this.myContext}) : super(key: key);

  @override
  State<TextFormWidget> createState() => _TextFormWidgetState();
}

class _TextFormWidgetState extends State<TextFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.name,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          enableInteractiveSelection: false,
          controller: widget.myController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          onChanged: (text){
            debugPrint("changed");
            debugPrint(text);

            _AddProductState().updateProvider(widget.myContext);

            debugPrint("Update prov");
            context.read<UpdateNetAmount>().calculateNetWeight();


          },

        ),
      ],
    );
  }
}


