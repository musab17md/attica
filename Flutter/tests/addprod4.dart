import 'package:ecom/constant/navbar.dart';
import 'package:flutter/material.dart';

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
  final TextEditingController _purityController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _grossWeightController = TextEditingController();
  final TextEditingController _stoneWeightController = TextEditingController();
  final TextEditingController _netWeightController = TextEditingController();
  final TextEditingController _makingChargeController = TextEditingController();
  final TextEditingController _wastageChargeController =
      TextEditingController();
  final TextEditingController _stoneChargeController = TextEditingController();
  final TextEditingController _totalAmountController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  String? _selectedMetal;
  String? _selectedOrnament;
  String? _selectedDay;

  @override
  void dispose() {
    _purityController.dispose();
    _rateController.dispose();
    _grossWeightController.dispose();
    _stoneWeightController.dispose();
    _netWeightController.dispose();
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
            // MyDropdownField(
            //     name: "Select Metal",
            //     valueList: vars.metalType,
            //     selected: _selectedMetal),
            SizedBox(height: paddingHeight),
            // MyDropdownField(
            //     name: "Select Ornament",
            //     valueList: vars.ornaments,
            //     selected: _selectedOrnament),
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
            MyTextFormField(
                name: "Net Weight", controller: _netWeightController),
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
            // MyDropdownField(
            //     name: "Select Day",
            //     valueList: vars.validDate,
            //     selected: _selectedDay),
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
                  debugPrint(_purityController.text);
                  debugPrint(_rateController.text);
                  debugPrint(_grossWeightController.text);
                  debugPrint(_stoneWeightController.text);
                  debugPrint(_netWeightController.text);
                  debugPrint(_makingChargeController.text);
                  debugPrint(_wastageChargeController.text);
                  debugPrint(_stoneChargeController.text);
                  debugPrint(_totalAmountController.text);
                  debugPrint(_quantityController.text);
                  debugPrint(_selectedMetal);
                  debugPrint(_selectedOrnament);
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

// class MyDropdownField extends StatefulWidget {
//   final String name;
//   final List<String> valueList;
//   String? selected;
//   MyDropdownField(
//       {super.key,
//       required this.name,
//       required this.valueList,
//       required this.selected});

//   @override
//   State<MyDropdownField> createState() => _MyDropdownFieldState();
// }

// class _MyDropdownFieldState extends State<MyDropdownField> {
//   final dropdownState = GlobalKey<FormFieldState>();

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: DropdownButtonFormField(
//         key: dropdownState,
//         hint: Text(widget.name),
//         decoration: const InputDecoration(
//           border: OutlineInputBorder(),
//         ),
//         items: widget.valueList.map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Text(value),
//           );
//         }).toList(),
//         onChanged: (value) {
//           setState(() {
//             widget.selected = value;
//           });
//         },
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return 'Please enter some text';
//           }
//           return null;
//         },
//       ),
//     );
//   }
// }
