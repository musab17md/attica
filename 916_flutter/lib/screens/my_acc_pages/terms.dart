import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../ui_elements/colors.dart';
import '../../widgets/app_bar.dart';

class TermsCondition extends StatefulWidget {
  const TermsCondition({super.key});

  @override
  State<TermsCondition> createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {
  String? data;

  void _loadData() async {
    final loadedData = await rootBundle.loadString('assets/terms.txt');
    setState(() {
      data = loadedData;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: const MyAppBar2(
        title: "Terms & Conditions",
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(child: Text(data ?? 'empty')),
      ),
    );
  }
}
