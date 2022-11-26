import 'package:flutter/material.dart';

class ProfileCard2 extends StatelessWidget {
  const ProfileCard2({super.key, required this.userdetail});
  final List? userdetail;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        color: const Color.fromARGB(255, 37, 116, 94),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/profilepic.png"),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Hello,"),
                const Text(
                  "Dr. Obaid,",
                  style: TextStyle(
                      shadows: [
                        Shadow(color: Colors.white, offset: Offset(0, -5))
                      ],
                      color: Colors.transparent,
                      decorationThickness: 1,
                      fontSize: 30.0,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.amber),
                ),
                const Text(
                  "Last entry : 15/11/2022 18:04",
                  style: TextStyle(fontSize: 10.0),
                ),
                Text(
                  "Account type : ${userdetail![1]}",
                  style: const TextStyle(fontSize: 10.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
