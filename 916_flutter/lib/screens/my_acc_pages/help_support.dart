import 'package:flutter/material.dart';
import 'package:flutter_gold/ui_elements/constant.dart';
import 'package:flutter_gold/ui_elements/widget_style.dart';
import 'package:flutter_gold/widgets/textfield.dart';
import 'package:sizer/sizer.dart';

import '../../ui_elements/colors.dart';
import '../../widgets/app_bar.dart';

class HelpSupport extends StatefulWidget {
  const HelpSupport({super.key});

  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  TextEditingController helpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: const MyAppBar2(
        title: "Help and Support",
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: kCardBackgroundColor,
                  elevation: cardElevation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 3.0),
                    child: Column(
                      children: const [
                        Text("Business Support : business@attica.com"),
                        Text("General Support : info@attica.com"),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: cardElevation,
                  color: kCardBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Whatsapp Support"),
                            SizedBox(
                              width: 70.w,
                              child: const Text(
                                "You can have live whatsapp chat with our support team.",
                                style: TextStyle(color: kText2),
                              ),
                            ),
                            MyButton(
                                onPressFunc: () {},
                                child: const Text("Chat Now")),
                          ],
                        ),
                        Icon(
                          Icons.whatsapp,
                          size: 32.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                elevation: cardElevation,
                color: kCardBackgroundColor,
                child: const ExpansionTile(
                  title: Text("How can I update my profile?"),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          "You can update your profile in App by navigating to My Account > Profile."),
                    ),
                  ],
                ),
              ),
              Card(
                elevation: cardElevation,
                color: kCardBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text(
                          "If you can't find a solution, You can write about your problem and send to us."),
                      const SizedBox(height: 10),
                      TextWidget(
                        label: "Describe your problem here",
                        icon: Icons.contact_support_outlined,
                        textType: TextInputType.text,
                        obscureTxt: false,
                        textControl: helpController,
                        maxLines: 5,
                      ),
                      MyButton(onPressFunc: () {}, child: const Text("Send")),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
