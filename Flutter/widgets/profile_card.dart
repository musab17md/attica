import 'package:flutter/material.dart';

import '../constant/vars.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.userdetail});
  final List? userdetail;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getTheme(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                elevation: 2,
                child: SizedBox(
                  width: double.infinity,
                  height: 180,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: FittedBox(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          fit: BoxFit.cover,
                          child: Image.asset("assets/background7.jpg"),
                        ),
                      ),
                      SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: ColoredBox(
                            color: const Color.fromARGB(255, 37, 116, 94)
                                .withOpacity(1) // 0: Light, 1: Dark
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/profilepic.png",
                                height: 150,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    "Hello,",
                                    style: TextStyle(
                                        color:
                                            MyColorOld().text1(snapshot.data)),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 5),
                                  child: Text(
                                    "Mr. Minam",
                                    style: TextStyle(
                                      color: MyColorOld().text1(snapshot.data),
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 5),
                                  child: Text(
                                    "Last entry : 15/11/2022 18:04",
                                    style: TextStyle(
                                      color: MyColorOld().text1(snapshot.data),
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 5),
                                  child: Text(
                                    "Account type : ${userdetail![1]}",
                                    style: TextStyle(
                                      color: MyColorOld().text1(snapshot.data),
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        });
  }
}
