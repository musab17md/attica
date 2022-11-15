import 'package:ecom/constant/navbar.dart';
import 'package:flutter/material.dart';

class VendorHome extends StatelessWidget {
  const VendorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDraw(),
      appBar: AppBar(
        title: const Text("916 Digital Gold"),
      ),
      body: const VeHome(),
    );
  }
}

class VeHome extends StatefulWidget {
  const VeHome({super.key});

  @override
  State<VeHome> createState() => _VeHomeState();
}

class _VeHomeState extends State<VeHome> {
  @override
  Widget build(BuildContext context) {
    return const Text("Home Page (Vendor)");
  }
}
