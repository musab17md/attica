import 'package:flutter/material.dart';
import 'package:attica/constant/vars.dart' as vars;

class DropDownTest extends StatefulWidget {
  const DropDownTest({super.key});

  @override
  State<DropDownTest> createState() => _DropDownTestState();
}

class DropdownValue {
  String _days = "";
  String get days => _days;
  void setDay(val) {
    _days = val;
  }
}

class _DropDownTestState extends State<DropDownTest> {
  DropdownValue daysObj = DropdownValue();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title"),
      ),
      body: Column(
        children: [
          Text("data"),
          DropDownForm(obj: daysObj),
          ElevatedButton(
            onPressed: () {
              debugPrint(daysObj.days);
            },
            child: Text("test"),
          ),
        ],
      ),
    );
  }
}

class DropDownForm extends StatelessWidget {
  const DropDownForm({super.key, required this.obj});
  final obj;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DropdownButtonFormField(
        hint: Text("widget.name"),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        items: vars.validDate.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          obj.setDay(value);
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
