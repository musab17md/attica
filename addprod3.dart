import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'core/api_client.dart';
import 'home.dart';
import 'navbar.dart';

class AddProduct3 extends StatelessWidget {
  const AddProduct3({super.key});

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

const List<String> metalType = <String>['Gold', 'Silver'];
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

const List<String> validDate = <String>[
  '1 Day',
  '3 Day',
  '7 Day',
  '15 Day',
  '30 Day'
];

String date = DateFormat('yMd').format(DateTime.now());

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  List<String> formValue = [
    "",
    "",
    "",
    "0",
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
    "Vendor",
    date,
    "Image 5",
    "Pending",
    "",
    "",
  ];
  String netWValue = "0";
  String netAValue = "0";
  String totalAValue = "0";
  double paddingHeight = 20.0;
  final _formKey = GlobalKey<FormState>();
  String? _selectedMetal;
  String? _selectedOrnament;
  String? _selectedDay;

  // var date =
  //     DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  multiplyNetAmount(val) {
    debugPrint(val.runtimeType.toString());
    var a = int.tryParse(formValue[10]) ?? 0;
    var b = int.tryParse(val) ?? 0;
    debugPrint("($a / 100) x $b");
    return (a / 100) * b;
  }

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

  getRate(context) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('last_rate') != null) {
      formValue[3] = prefs.getStringList('last_rate')![1];
      setState(() {});
    } else {
      showAction(context);
    }
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
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const MyHome())),
                          (route) => false);
                    },
                    child: const Text("Done")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.popAndPushNamed(context, '/addProd');
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

  submitForm() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> myList = [
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
      formValue[17],
      formValue[18],
      formValue[19]
    ];
    await prefs.setStringList('last_post', myList);
    ApiClient().postData(myList).then((value) {
      debugPrint(value.toString());
      debugPrint("value.toString()");
      createProduct(context, value);
    });
  }

  @override
  Widget build(BuildContext context) {
    getRate(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: paddingHeight),
                buildSelectMetalForm(),
                SizedBox(height: paddingHeight),
                // TextFormField(
                //   enableInteractiveSelection: false,
                //   decoration: const InputDecoration(
                //     label: Text("Ornament"),
                //     border: OutlineInputBorder(),
                //   ),
                //   keyboardType: TextInputType.text,
                //   textInputAction: TextInputAction.next,
                //   onChanged: (text) {
                //     formValue[1] = text;
                //     debugPrint(formValue.toString());
                //   },
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter some text';
                //     }
                //     return null;
                //   },
                // ),
                buildOrnamentTypeForm(),
                SizedBox(height: paddingHeight),
                TextFormField(
                  enableInteractiveSelection: false,
                  decoration: const InputDecoration(
                    label: Text("Purity %"),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  onChanged: (text) {
                    formValue[2] = text;
                    debugPrint(formValue.toString());
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(height: paddingHeight),
                TextFormField(
                  readOnly: true,
                  controller: TextEditingController()..text = formValue[3],
                  enableInteractiveSelection: false,
                  decoration: const InputDecoration(
                    label: Text("Rate"),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
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
                  textInputAction: TextInputAction.done,
                  onChanged: (text) {
                    formValue[5] = text;
                    updateAll();
                    debugPrint(formValue.toString());
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(height: paddingHeight),
                TextFormField(
                  readOnly: true,
                  // key: Key(netWValue.toString()),
                  // initialValue: netWValue,
                  controller: TextEditingController()..text = netWValue,
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
                  enableInteractiveSelection: false,
                  decoration: const InputDecoration(
                    label: Text("Making Charge %"),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  onChanged: (text) {
                    formValue[18] = text.toString();
                    formValue[6] = multiplyNetAmount(text).toString();
                    updateAll();
                    debugPrint(formValue.toString());
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
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
                    formValue[19] = text.toString();
                    formValue[7] = multiplyNetAmount(text).toString();
                    updateAll();
                    debugPrint(formValue.toString());
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(height: paddingHeight),
                TextFormField(
                  readOnly: true,
                  // key: Key(totalAValue.toString()),
                  // initialValue: totalAValue,
                  controller: TextEditingController()..text = totalAValue,
                  enableInteractiveSelection: false,
                  decoration: const InputDecoration(
                    label: Text("Total Amount"),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: paddingHeight),
                // TextFormField(
                //   enableInteractiveSelection: false,
                //   decoration: const InputDecoration(
                //     label: Text("Valid D"),
                //     border: OutlineInputBorder(),
                //   ),
                //   keyboardType: TextInputType.number,
                //   textInputAction: TextInputAction.next,
                //   onChanged: (text) {
                //     formValue[12] = text;
                //     debugPrint(formValue.toString());
                //   },
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter some text';
                //     }
                //     return null;
                //   },
                // ),
                buildValidityDateForm(),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(height: paddingHeight),
                // TextFormField(
                //   enableInteractiveSelection: false,
                //   decoration: const InputDecoration(
                //     label: Text("Vendor"),
                //     border: OutlineInputBorder(),
                //   ),
                //   keyboardType: TextInputType.number,
                //   textInputAction: TextInputAction.next,
                //   onChanged: (text) {
                //     formValue[14] = text;
                //     debugPrint(formValue.toString());
                //   },
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter some text';
                //     }
                //     return null;
                //   },
                // ),
                // SizedBox(height: paddingHeight),
                // TextFormField(
                //   enableInteractiveSelection: false,
                //   decoration: const InputDecoration(
                //     label: Text("Submit Date"),
                //     border: OutlineInputBorder(),
                //   ),
                //   keyboardType: TextInputType.number,
                //   textInputAction: TextInputAction.next,
                //   onChanged: (text) {
                //     formValue[15] = text;
                //     debugPrint(formValue.toString());
                //   },
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter some text';
                //     }
                //     return null;
                //   },
                // ),
                // SizedBox(height: paddingHeight),
                // TextFormField(
                //   enableInteractiveSelection: false,
                //   decoration: const InputDecoration(
                //     label: Text("Image"),
                //     border: OutlineInputBorder(),
                //   ),
                //   keyboardType: TextInputType.number,
                //   textInputAction: TextInputAction.next,
                //   onChanged: (text) {
                //     formValue[16] = text;
                //     debugPrint(formValue.toString());
                //   },
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter some text';
                //     }
                //     return null;
                //   },
                // ),
                // SizedBox(height: paddingHeight),
                // TextFormField(
                //   enableInteractiveSelection: false,
                //   decoration: const InputDecoration(
                //     label: Text("Status"),
                //     border: OutlineInputBorder(),
                //   ),
                //   keyboardType: TextInputType.number,
                //   textInputAction: TextInputAction.next,
                //   onChanged: (text) {
                //     formValue[17] = text;
                //     debugPrint(formValue.toString());
                //   },
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter some text';
                //     }
                //     return null;
                //   },
                // ),

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
                // ElevatedButton(
                //     onPressed: () {
                //       debugPrint(date.toString());
                //     },
                //     child: const Text("Test")),
              ],
            )),
      ),
    );
  }

  Column buildSelectMetalForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 60,
          child: InputDecorator(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Select Metal",
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: _selectedMetal,
                hint: const Text("Select Metal"),
                onChanged: (String? value) {
                  setState(() {
                    formValue[0] = value.toString();
                    _selectedMetal = value ?? "";
                  });
                },
                items: metalType.map<DropdownMenuItem<String>>((String value) {
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

  Column buildOrnamentTypeForm() {
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
                onChanged: (value) {
                  setState(() {
                    formValue[1] = value.toString();
                    _selectedOrnament = value;
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

  Column buildValidityDateForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 60,
          child: InputDecorator(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Select Day",
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: _selectedDay,
                hint: const Text("Select Day"),
                onChanged: (value) {
                  setState(() {
                    formValue[12] = value.toString();
                    _selectedDay = value;
                  });
                },
                items: validDate.map<DropdownMenuItem<String>>((String value) {
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
