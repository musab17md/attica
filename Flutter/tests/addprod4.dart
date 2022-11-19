import 'package:ecom/constant/navbar.dart';
import 'package:flutter/material.dart';
import 'package:ecom/constant/vars.dart' as vars;

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

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _purityController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _grossWeightController = TextEditingController();
  final TextEditingController _stoneWeightController = TextEditingController();
  final TextEditingController _makingChargeController = TextEditingController();
  final TextEditingController _wastageChargeController =
      TextEditingController();
  final TextEditingController _stoneChargeController = TextEditingController();
  final TextEditingController _totalAmountController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  String? _selectedMetal;
  String? _selectedOrnament;
  String? _selectedDay;

  int _netWeightValue = 0;
  int _netAmountValue = 0;

  @override
  void dispose() {
    _purityController.dispose();
    _rateController.dispose();
    _grossWeightController.dispose();
    _stoneWeightController.dispose();
    _makingChargeController.dispose();
    _wastageChargeController.dispose();
    _stoneChargeController.dispose();
    _totalAmountController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  double paddingHeight = 20.0;
  final _formKey = GlobalKey<FormState>();

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

  void _calculate() {
    debugPrint("called setweight");
    int grossweight = int.tryParse(_grossWeightController.text) ?? 0;
    int stoneweight = int.tryParse(_stoneWeightController.text) ?? 0;
    int rate = int.tryParse(_rateController.text) ?? 0;
    var totalweight = grossweight - stoneweight;
    var totalNetAmt = totalweight * rate;
    setState(() {
      _netWeightValue = totalweight;
      _netAmountValue = totalNetAmt;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stoneWeightController.addListener(_calculate);
    _grossWeightController.addListener(_calculate);
    _grossWeightController.addListener(_calculate);
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
                selected: _selectedMetal),
            SizedBox(height: paddingHeight),
            MyDropdownField(
                name: "Select Ornament",
                valueList: vars.ornaments,
                selected: _selectedOrnament),
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
            MyTextFormField(
                name: "Total Amount", controller: _totalAmountController),
            SizedBox(height: paddingHeight),
            MyDropdownField(
                name: "Select Day",
                valueList: vars.validDate,
                selected: _selectedDay),
            SizedBox(height: paddingHeight),
            MyTextFormField(name: "Quantity", controller: _quantityController),
            SizedBox(height: paddingHeight),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
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
                  debugPrint(_selectedMetal);
                  debugPrint(_selectedOrnament);
                  debugPrint(_purityController.text);
                  debugPrint(_rateController.text);
                  debugPrint(_grossWeightController.text);
                  debugPrint(_stoneWeightController.text);
                  debugPrint(_makingChargeController.text);
                  debugPrint(_wastageChargeController.text);
                  debugPrint(_stoneChargeController.text);
                  debugPrint(_totalAmountController.text);
                  debugPrint(_quantityController.text);
                  debugPrint(_selectedDay);
                },
                child: const Text("Test")),
          ],
        ));
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
  String? selected;
  MyDropdownField(
      {super.key,
      required this.name,
      required this.valueList,
      required this.selected});

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
          setState(() {
            widget.selected = value;
          });
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

// class SelectOrnamentPhoto extends StatefulWidget {
//   const SelectOrnamentPhoto({super.key});

//   @override
//   State<SelectOrnamentPhoto> createState() => _SelectOrnamentPhotoState();
// }

// class _SelectOrnamentPhotoState extends State<SelectOrnamentPhoto> {

//   var mydata;

//   getPhotographerImages() async {
//     String spacelessOrnament = formValue[1].replaceAll(" ", "_");
//     final uri = Uri.http('192.168.0.134:8123', '/pics/$spacelessOrnament/');
//     final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
//     final response = await http.get(uri, headers: headers);
//     debugPrint(response.body);
//     mydata = jsonDecode(response.body);
//     return mydata;
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.only(left: 12.0, bottom: 8.0, top: 12.0),
//           child: SizedBox(
//             child: Text(
//               "Select Photographer's Ornament",
//               textAlign: TextAlign.start,
//             ),
//           ),
//         ),
//         Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(
//                 color: Colors.grey,
//               )),
//           child: Row(
//             children: [
//               SizedBox(
//                 width: 150,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (formValue[1] != "") {
//                         getPhotographerImages();
//                         showDialog(
//                             context: context,
//                             builder: (context) {
//                               return FutureBuilder(
//                                   future: getPhotographerImages(),
//                                   builder: (context, snapshot) {
//                                     if (snapshot.hasData) {
//                                       return ListView.builder(
//                                           itemCount: mydata == null
//                                               ? 0
//                                               : mydata?.length,
//                                           itemBuilder: (BuildContext context,
//                                               int index) {
//                                             debugPrint(mydata.toString());
//                                             return Padding(
//                                               padding:
//                                                   const EdgeInsets.all(8.0),
//                                               child: GestureDetector(
//                                                 onTap: () {
//                                                   formValue[16] = mydata[0]
//                                                           ["id"]
//                                                       .toString();
//                                                   selectedPhotoUrl =
//                                                       mydata[0]["model1"];
//                                                   Navigator.pop(context);
//                                                 },
//                                                 child: Card(
//                                                   child: Column(
//                                                     children: [
//                                                       Text(
//                                                           "By: ${mydata[0]["vendor"]}"),
//                                                       Text(
//                                                           "Date: ${mydata[0]["date"]}"),
//                                                       SizedBox(
//                                                         height: 200,
//                                                         width: 200,
//                                                         child: PhotoView(
//                                                           imageProvider:
//                                                               NetworkImage(
//                                                                   mydata[0][
//                                                                       "model1"]),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             );
//                                           });
//                                     }
//                                     return const Center(
//                                         child: CircularProgressIndicator());
//                                   });
//                             });
//                       }
//                     },
//                     child: const Text("Choose File"),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: (formValue[16] == "")
//                     ? const Text(
//                         "Select an Image",
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       )
//                     : Stack(alignment: Alignment.topRight, children: [
//                         SizedBox(
//                             height: 200,
//                             width: 200,
//                             child: PhotoView(
//                               imageProvider: NetworkImage(selectedPhotoUrl!),
//                             )),
//                         GestureDetector(
//                           onTap: () {
//                             formValue[16] = "";
//                           },
//                           child: Container(
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(50),
//                                   color: Colors.grey[850]),
//                               child: const Padding(
//                                 padding: EdgeInsets.all(2.0),
//                                 child: Icon(Icons.close),
//                               )),
//                         )
//                       ]),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }