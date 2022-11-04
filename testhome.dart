import 'package:flutter/material.dart';

import 'navbar.dart';

class TestHome extends StatefulWidget {
  const TestHome({Key? key}) : super(key: key);

  @override
  State<TestHome> createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      debugPrint(_selectedIndex.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDraw(),
      appBar: AppBar(
        title: const Text("916 Digital Gold"),
      ),
      body: _selectedIndex == 0 ? buildHomePage(context) : buildShopping(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Shopping',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildShopping() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(
          child: Text("Shopping Page"),
        ),
      ],
    );
  }

  Widget buildHomePage(BuildContext context) {
    double screenWidth = 420;
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Container(
                color: Theme.of(context).primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Text("916 DIGITAL GOLD",
                          style: TextStyle(
                              fontSize: 30.00,
                              color: Colors.red,
                              fontStyle: FontStyle.italic)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text("Wallet Balance",
                          style: TextStyle(
                            fontSize: 25.00,
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text("₹ 3800.89",
                          style: TextStyle(
                            fontSize: 25.00,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(60, 230, 60, 0),
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.brown[200],
              ),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    // SizedBox(
                    //   height: 20,
                    //   child: TextButton(onPressed: () {}, child: const Icon(Icons.currency_rupee)),
                    // ),
                    const TextField(
                      decoration: InputDecoration(
                          hintText: "Amount",
                          prefixIcon: Icon(Icons.currency_rupee)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Add Amount")),
                  ],
                ),
              ), // , style: TextStyle(color: getThemeVal() ? Colors.blue : Colors.amber )
            ),
          ],
        ),
        const SizedBox(
          height: 60,
        ),
        SizedBox(
          height: 200,
          child: ListView(
            // This next line does the trick.
            scrollDirection: Axis.horizontal,
            physics: const PageScrollPhysics(),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                width: screenWidth - 40,
                color: Colors.red,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                width: screenWidth - 40,
                color: Colors.blue,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                width: screenWidth - 40,
                color: Colors.green,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                width: screenWidth - 40,
                color: Colors.yellow,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                width: screenWidth - 40,
                color: Colors.orange,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                width: screenWidth - 40,
                color: Colors.orange,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
