import 'package:flutter/material.dart';

class GetCurrTheme extends StatefulWidget {
  const GetCurrTheme({super.key});

  @override
  State<GetCurrTheme> createState() => _GetCurrThemeState();
}

class _GetCurrThemeState extends State<GetCurrTheme> {
  var currtheme;

  getTh() {
    // currtheme = Provider.of<ThemeChanger>(context, listen: false).getTheme();
    debugPrint(currtheme.runtimeType.toString());
    debugPrint(currtheme.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GetCurrTheme"),
      ),
      body: Column(
        children: [
          Text("Current Theme is : $currtheme"),
          ElevatedButton(
              onPressed: () {
                getTh();
              },
              child: const Text("Theme?")),
        ],
      ),
    );
  }
}
// ThemeData#30b25
// ThemeData#50e19
// ThemeData#1d202
// ThemeData#20baa

