import 'package:flutter/material.dart';

import '../constant/navbar.dart';
import '../constant/vars.dart';
import '../widgets/form_dropdown.dart';
import '../widgets/form_text.dart';
import '../constant/vars.dart' as vars;

class AddGoldDetail extends StatelessWidget {
  const AddGoldDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColorOld().background(),
      drawer: const NavDraw(),
      appBar: AppBar(
        title: const Text("Details for Assigned product"),
      ),
      body: const FormWidgetDetails(),
    );
  }
}

class DropdownValue {
  String _HmPrint = "";
  String _916pack = "";

  String get days => _HmPrint;
  String get metal => _916pack;

  void setDay(val) {
    _HmPrint = val;
  }

  void setMetal(val) {
    _916pack = val;
  }
}

class FormWidgetDetails extends StatefulWidget {
  const FormWidgetDetails({super.key});

  @override
  State<FormWidgetDetails> createState() => _FormWidgetDetailsState();
}

class _FormWidgetDetailsState extends State<FormWidgetDetails> {
  final _formKey = GlobalKey<FormState>();
  final paddingHeight = 15.0;

  final TextEditingController _hallMarkController = TextEditingController();
  final TextEditingController _netWeightController = TextEditingController();
  final TextEditingController _grossWeightController = TextEditingController();

  @override
  void dispose() {
    _hallMarkController.dispose();
    _netWeightController.dispose();
    _grossWeightController.dispose();
    super.dispose();
  }

  DropdownValue dropDownObj = DropdownValue();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: paddingHeight),
            MyTextFormField(
              name: "Hall Mark",
              controller: _hallMarkController,
              txtType: TextInputType.text,
            ),
            SizedBox(height: paddingHeight),
            MyTextFormField(
              name: "Net Weight",
              controller: _netWeightController,
              txtType: TextInputType.text,
            ),
            SizedBox(height: paddingHeight),
            MyTextFormField(
              name: "Gross Weight",
              controller: _grossWeightController,
              txtType: TextInputType.text,
            ),
            SizedBox(height: paddingHeight),
            MyDropdownField(
              name: "Hall Mark Print",
              valueList: vars.yesNo,
              obj: dropDownObj,
              setType: 'metal',
            ),
            SizedBox(height: paddingHeight),
            MyDropdownField(
              name: "916 Package",
              valueList: vars.yesNo,
              obj: dropDownObj,
              setType: 'metal',
            ),
            SizedBox(height: paddingHeight),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: MyColorOld().icon2()),
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
