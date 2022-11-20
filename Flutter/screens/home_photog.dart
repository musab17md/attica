import 'package:attica/constant/navbar.dart';
import 'package:flutter/material.dart';

class PhotoHome extends StatelessWidget {
  const PhotoHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDraw(),
      appBar: AppBar(
        title: const Text("916 Digital Gold"),
      ),
      body: const PhotographerHome(),
    );
  }
}

class PhotographerHome extends StatefulWidget {
  const PhotographerHome({super.key});

  @override
  State<PhotographerHome> createState() => _PhotographerHomeState();
}

class _PhotographerHomeState extends State<PhotographerHome> {
  @override
  Widget build(BuildContext context) {
    return const Text("Home Page (Photo)");
  }
}
