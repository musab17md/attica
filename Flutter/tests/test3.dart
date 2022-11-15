import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Test3 extends StatefulWidget {
  const Test3({super.key});

  @override
  State<Test3> createState() => _Test3State();
}

class _Test3State extends State<Test3> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            // String token = await getToken();
            // String body = {'status': 'App'};
            Response response = await patch(
              Uri.parse("http://192.168.0.134:8123/pics/24/"),
              headers: {
                "Content-Type": "application/json",
                // "Authorization": "Token $token"
              },
              body: {'status': 'App'},
            );
          },
          child: const Text("Click"),
        ),
      ],
    );
  }
}
