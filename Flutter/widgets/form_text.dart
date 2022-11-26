import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  final TextInputType txtType;

  const MyTextFormField(
      {super.key,
      required this.name,
      required this.controller,
      required this.txtType});

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
