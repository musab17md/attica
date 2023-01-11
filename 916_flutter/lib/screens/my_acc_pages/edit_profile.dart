import 'package:flutter/material.dart';
import 'package:flutter_gold/widgets/textfield.dart';
import 'package:sizer/sizer.dart';

import '../../ui_elements/colors.dart';
import '../../widgets/app_bar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();

  TextEditingController mobileController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: const MyAppBar2(
        title: "Edit Profile",
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Icon(
              Icons.person,
              size: 100,
            ),
            const SizedBox(height: 10),
            TextWidget(
              label: "Name",
              icon: Icons.person,
              textType: TextInputType.name,
              obscureTxt: false,
              textControl: nameController,
            ),
            const SizedBox(height: 10),
            TextWidget(
              label: "Mobile",
              icon: Icons.phone_android_outlined,
              textType: TextInputType.number,
              obscureTxt: false,
              textControl: mobileController,
            ),
            const SizedBox(height: 10),
            TextWidget(
              label: "Email",
              icon: Icons.mail,
              textType: TextInputType.emailAddress,
              obscureTxt: false,
              textControl: emailController,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 50.w,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: kButton,
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(color: kButtonText),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
