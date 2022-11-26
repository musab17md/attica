import 'package:flutter/material.dart';

class MyDropdownField extends StatefulWidget {
  final String name;
  final List<String> valueList;
  final dynamic obj;
  final String setType;
  const MyDropdownField(
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
