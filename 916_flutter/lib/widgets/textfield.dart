import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ui_elements/colors.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {super.key,
      required this.label,
      required this.icon,
      required this.textType,
      required this.obscureTxt,
      required this.textControl,
      this.expands,
      this.maxLines});
  final String label;
  final IconData icon;
  final TextInputType textType;
  final bool obscureTxt;
  final TextEditingController textControl;
  final bool? expands;
  final int? maxLines;

  inputBorder(double width, Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(width: width, color: color),
      borderRadius: BorderRadius.circular(50.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textControl,
      style: GoogleFonts.lato(),
      obscureText: obscureTxt,
      keyboardType: textType,
      expands: (expands == null) ? false : expands as bool,
      maxLines: (maxLines == null) ? 1 : maxLines,
      decoration: InputDecoration(
          filled: true,
          fillColor: kBackgroundColor,
          errorBorder: inputBorder(2, Colors.greenAccent),
          focusedBorder: inputBorder(2, kGold),
          focusedErrorBorder: inputBorder(2, Colors.greenAccent),
          disabledBorder: inputBorder(2, Colors.greenAccent),
          enabledBorder: inputBorder(2, Colors.greenAccent),
          border: inputBorder(2, Colors.greenAccent),
          label: Text(
            label,
            style: const TextStyle(color: Colors.grey),
          ),
          prefixIcon: Icon(icon)),
    );
  }
}
