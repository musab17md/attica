import '../constant/navbar.dart';
import '../widgets/banner_slider.dart';
import 'package:flutter/material.dart';

import '../widgets/shortcut_icons.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDraw(),
      appBar: AppBar(
        title: const Text("916 Digital Gold"),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.notifications),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background5.webp"),
            fit: BoxFit.cover,
          ),
        ),
        child: const MainHome(),
      ),
    );
  }
}

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const SearchWidget(),
        const SizedBox(height: 10),
        const BannerView2(),
        const SizedBox(height: 20),
        const ShortcutIconBar(userdetail: ["", "Design"]),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 2,
            child: SizedBox(
              width: double.infinity,
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      "Hello,",
                      style: TextStyle(color: Colors.brown[700], fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      "Mr. Attica Gold",
                      style: TextStyle(color: Colors.brown[700], fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      "Last entry : 15/11/2022 18:04",
                      style: TextStyle(color: Colors.brown[700], fontSize: 10),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      "Account type : Admin",
                      style: TextStyle(color: Colors.brown[700], fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(6.0),
      child: Card(
        elevation: 8,
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
              borderSide: BorderSide(width: 0, style: BorderStyle.none),
            ),
            filled: true,
            prefixIcon: Icon(Icons.search),
            hintText: "Search database",
          ),
          autofocus: false,
        ),
      ),
    );
  }
}
