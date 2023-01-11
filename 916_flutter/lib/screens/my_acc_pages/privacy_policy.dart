import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../ui_elements/colors.dart';
import '../../widgets/app_bar.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  String? data;

  void _loadData() async {
    final loadedData = await rootBundle.loadString('assets/privacy.txt');
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
        title: "Privacy Policy",
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(child: Text(data ?? 'empty')),
      ),
    );
  }
}
