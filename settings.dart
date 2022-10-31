import 'package:ecom/navbar.dart';
import 'package:ecom/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

saveTheme(thm) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('theme', thm);
}

class _SettingsState extends State<Settings> {
  bool isSwitched = false;

  getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("theme");
  }

  getSwitchValues() async {
    isSwitched = await getTheme();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getSwitchValues();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return Scaffold(
      drawer: const NavDraw(),
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.brightness_medium_outlined),
                title: const Text("Dark Theme"),
                trailing: Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                    isSwitched == false ? theme.setTheme(ThemeData.light()) : theme.setTheme(ThemeData.dark());
                    saveTheme(isSwitched);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
