import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../ui_elements.dart/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kBackgroundColor,
        title: const Text('Profile'),
        actions: [
          TextButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: kBackgroundColor,
                        title: const Text(
                          "Logout of App?",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: kWhite),
                        ),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                child: const Text(
                                  "Cancel",
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 30.0,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                child: const Text("Logout"),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red, fontSize: 50.0),
              )),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 150,
                  child: Image(
                    image: AssetImage('assets/logo.png'),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 1.0,
                  margin: const EdgeInsets.symmetric(vertical: 60),
                  color: kCardBackgroundColor,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const UserCards(
                        icon: Icons.perm_identity,
                        name: "Musab",
                        colour: kLightGreen,
                      ),
                      const UserCards(
                        icon: Icons.verified_user,
                        name: "msb",
                        colour: kLightYellow,
                      ),
                      const UserCards(
                        icon: Icons.school,
                        name: (true) ? 'LNCTU' : 'LNCT',
                        colour: kLightRed,
                      ),
                      const UserCards(
                        icon: Icons.menu_book,
                        name: "Semester",
                        colour: Colors.white70,
                      ),
                      const UserCards(
                        icon: Icons.menu_book,
                        name: 'branch',
                        colour: kLightYellow,
                      ),
                      GestureDetector(
                        onTap: () async {},
                        child: const UserCards(
                          icon: Icons.document_scanner_rounded,
                          name: 'Privacy Policy',
                          colour: Colors.green,
                          borderColor: Colors.green,
                        ),
                      ),
                      const SizedBox(
                        height: 100.0,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    navigateButton(
                        title: 'Linkedin',
                        url:
                            'https://www.linkedin.com/in/adarsh-soni-7892aa198/',
                        iconData: FontAwesomeIcons.linkedin),
                    navigateButton(
                      title: 'Github',
                      url: 'https://github.com/Adarsh9497/LNCT-Attendance',
                      iconData: FontAwesomeIcons.github,
                    ),
                    Column(
                      children: [
                        IconButton(
                            onPressed: () async {},
                            icon: const Icon(
                              FontAwesomeIcons.shareNodes,
                              color: kWhite,
                              size: 80,
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Share app',
                          textScaleFactor: 1.0,
                          style: TextStyle(color: kWhite, fontSize: 40),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            onPressed: () async {},
                            icon: const Icon(
                              FontAwesomeIcons.bug,
                              color: kWhite,
                              size: 80,
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Feedback',
                          textScaleFactor: 1.0,
                          style: TextStyle(color: kWhite, fontSize: 40),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget navigateButton(
      {required String title,
      required String url,
      required IconData iconData}) {
    return Column(
      children: [
        IconButton(
            onPressed: () async {},
            icon: Icon(
              iconData,
              color: kWhite,
              size: 80,
            )),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          textScaleFactor: 1.0,
          style: const TextStyle(color: kWhite, fontSize: 40),
        ),
      ],
    );
  }
}

class UserCards extends StatelessWidget {
  const UserCards(
      {super.key,
      required this.icon,
      required this.name,
      required this.colour,
      this.borderColor});
  final IconData icon;
  final String name;
  final Color colour;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
              color: borderColor ?? kCardBackgroundColor, width: 2.0)),
      child: ListTile(
        leading: Icon(
          icon,
          color: colour,
          size: 60,
        ),
        title: Text(
          name,
          maxLines: 2,
          textScaleFactor: 1.0,
          style: TextStyle(
            fontSize: 46,
            color: colour,
          ),
        ),
      ),
    );
  }
}
