import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../ui_elements/colors.dart';
import '../../ui_elements/widget_style.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/choice_pills.dart';
import '../../widgets/textfield.dart';

class MyAddress extends StatelessWidget {
  const MyAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: const MyAppBar2(
        title: "My Address",
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context, builder: (context) => const AddAddress());
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            ListTile(
              leading: Icon(Icons.location_on_outlined),
              title: Text("HSR Layout"),
              trailing: Icon(Icons.close),
            ),
            ListTile(
              leading: Icon(Icons.location_on_outlined),
              title: Text("HSR Layout"),
              trailing: Icon(Icons.close),
            ),
            ListTile(
              leading: Icon(Icons.location_on_outlined),
              title: Text("HSR Layout"),
              trailing: Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }
}

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  String selected = "Home";
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Add Address",
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  const SizedBox(height: 10),
                  TextWidget(
                    label: "Full Name",
                    icon: Icons.person,
                    textType: TextInputType.name,
                    obscureTxt: false,
                    textControl: nameController,
                  ),
                  const SizedBox(height: 10),
                  TextWidget(
                    label: "Mobile Number",
                    icon: Icons.phone_android,
                    textType: TextInputType.number,
                    obscureTxt: false,
                    textControl: mobileController,
                  ),
                  const SizedBox(height: 10),
                  TextWidget(
                    label: "Email Address",
                    icon: Icons.mail,
                    textType: TextInputType.emailAddress,
                    obscureTxt: false,
                    textControl: mailController,
                  ),
                  const SizedBox(height: 10),
                  TextWidget(
                    label: "Address",
                    icon: Icons.location_city,
                    textType: TextInputType.text,
                    obscureTxt: false,
                    textControl: addressController,
                  ),
                  const SizedBox(height: 10),
                  TextWidget(
                    label: "Landmark",
                    icon: Icons.location_searching_outlined,
                    textType: TextInputType.text,
                    obscureTxt: false,
                    textControl: landmarkController,
                  ),
                  const SizedBox(height: 10),
                  TextWidget(
                    label: "City",
                    icon: Icons.maps_home_work_sharp,
                    textType: TextInputType.text,
                    obscureTxt: false,
                    textControl: cityController,
                  ),
                  const SizedBox(height: 10),
                  TextWidget(
                    label: "Zip Code",
                    icon: Icons.onetwothree,
                    textType: TextInputType.text,
                    obscureTxt: false,
                    textControl: zipController,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          selected = "Home";
                          setState(() {});
                        },
                        child: ChoicePills(
                          text: 'Home',
                          selected: selected,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          selected = "Office";
                          setState(() {});
                        },
                        child: ChoicePills(
                          text: 'Office',
                          selected: selected,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          selected = "Other";
                          setState(() {});
                        },
                        child: ChoicePills(
                          text: 'Other',
                          selected: selected,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 50.w,
                    child: MyButton(
                        onPressFunc: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Save")),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
