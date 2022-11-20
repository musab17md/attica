import 'dart:convert';

import 'package:attica/constant/navbar.dart';
import 'package:attica/constant/urls.dart';
import 'package:attica/constant/vars.dart';
import 'package:attica/core/api_client.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddGoldRate extends StatefulWidget {
  const AddGoldRate({super.key});

  @override
  State<AddGoldRate> createState() => _AddGoldRateState();
}

class _AddGoldRateState extends State<AddGoldRate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDraw(),
      appBar: AppBar(
        title: const Text("Add Gold Rate"),
      ),
      body: const GoldRateWidget(),
    );
  }
}

const List<String> metalType = <String>['Gold', 'Silver'];

String date = DateFormat('dd/MM/yyyy').format(DateTime.now());
String time = DateFormat('HH:mm:ss').format(DateTime.now());

class GoldRateWidget extends StatefulWidget {
  const GoldRateWidget({super.key});

  @override
  State<GoldRateWidget> createState() => _GoldRateWidgetState();
}

class _GoldRateWidgetState extends State<GoldRateWidget> {
  String? _selectedMetal;
  String _goldRate = "";
  final _formKey = GlobalKey<FormState>();

  submitForm() async {
    var userkey = await getUser();
    // List<String> myList = [
    //   _selectedMetal ?? "",
    //   _goldRate,
    //   time,
    //   date,
    // ];
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setStringList('last_rate', myList);
    // postApiHere

    // get or create gold rate
    // get gold rate from vendor id else create gold rate on vendor id
    Map<String, String> body = {
      'metal': _selectedMetal.toString(),
      'rate': _goldRate,
      'vendor': userkey[1],
      'vendor_id': userkey[0],
      'time': time,
      'date': date,
    };
    Response response = await ApiClient().postJson(urlGold, jsonEncode(body));
    debugPrint(jsonDecode(response.body).toString());
  }

  clearPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('last_rate');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            buildGoldRateForm(),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              enableInteractiveSelection: false,
              decoration: const InputDecoration(
                label: Text("Gold Rate"),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              onChanged: (text) {
                _goldRate = text;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
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
                    submitForm();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Form Invalid, Please check.')),
                    );
                  }
                },
                child: const Text("Submit"),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       debugPrint(_selectedMetal.toString());
            //       debugPrint(_goldRate.toString());
            //       debugPrint(time.toString());
            //       debugPrint(date.toString());
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
    );
  }

  Column buildGoldRateForm() {
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
}
