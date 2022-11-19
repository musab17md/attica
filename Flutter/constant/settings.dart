import 'package:ecom/constant/navbar.dart';
import 'package:ecom/core/api_client.dart';
import 'package:ecom/core/theme.dart';
import 'package:ecom/register/login.dart';
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
    return prefs.getBool("theme") ?? false;
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
                    isSwitched == false
                        ? theme.setTheme(ThemeData.light())
                        : theme.setTheme(ThemeData.dark());
                    saveTheme(isSwitched);
                  },
                ),
              ),
            ),
            // Card(
            //   child: ListTile(
            //     leading: const Icon(Icons.brightness_medium_outlined),
            //     title: const Text("Users"),
            //     trailing: ElevatedButton(
            //       onPressed: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: ((context) => const UserControl())));
            //       },
            //       child: const Text("View (dev)"),
            //     ),
            //   ),
            // ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.lock_reset_outlined),
                title: const Text("Change your password"),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const PassChange())));
                  },
                  child: const Text("Reset"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PassChange extends StatefulWidget {
  const PassChange({super.key});

  @override
  State<PassChange> createState() => _PassChangeState();
}

class _PassChangeState extends State<PassChange> {
  final TextEditingController oldPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? previousPass = "";
  String? username = "";

  @override
  void dispose() {
    oldPassController.dispose();
    newPassController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  getOldPass() async {
    final prefs = await SharedPreferences.getInstance();
    var userKey = prefs.getStringList("userKey");
    print("userkey");
    debugPrint(userKey.toString());
    previousPass = userKey?[2];
    debugPrint(previousPass);
  }

  getOldPass2() async {
    final prefs = await SharedPreferences.getInstance();
    List? keys = prefs.getStringList('userkey');
    previousPass = keys?[2];
    username = keys?[1];
  }

  @override
  void initState() {
    getOldPass2();
    super.initState();
  }

  changePassword() {
    ApiClient().changePass(username, newPassController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDraw(),
      appBar: AppBar(
        title: const Text("Change Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: oldPassController,
                enableInteractiveSelection: false,
                decoration: const InputDecoration(
                  label: Text("Old Password"),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value != previousPass) {
                    return 'Please enter correct password';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: newPassController,
                enableInteractiveSelection: false,
                decoration: const InputDecoration(
                  label: Text("New Password"),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (value != confirmPassController.text) {
                    return 'Password didnt match';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: confirmPassController,
                enableInteractiveSelection: false,
                decoration: const InputDecoration(
                  label: Text("Re-Enter Password"),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (value != newPassController.text) {
                    return 'Password didnt match';
                  }
                  return null;
                },
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      changePassword();
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Successful"),
                              content:
                                  const Text("Password changed successfully."),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    SharedPreferences.getInstance()
                                        .then((value) {
                                      // value.remove('token');
                                      value.remove('userkey');
                                    });
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                const LoginPage())),
                                        (route) => false);
                                  },
                                  child: const Text("Done"),
                                ),
                              ],
                            );
                          });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Form Invalid, Please check.')),
                      );
                    }
                  },
                  child: const Text("Send Data"),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    debugPrint(oldPassController.text);
                    debugPrint(newPassController.text);
                    debugPrint(confirmPassController.text);
                  },
                  child: const Text("Test"))
            ],
          ),
        ),
      ),
    );
  }
}
