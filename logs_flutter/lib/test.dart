import 'package:flutter/material.dart';

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TestObj(),
    );
  }
}

class TestObj extends StatefulWidget {
  const TestObj({super.key});

  @override
  State<TestObj> createState() => _TestObjState();
}

class _TestObjState extends State<TestObj> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
    );
  }
}
