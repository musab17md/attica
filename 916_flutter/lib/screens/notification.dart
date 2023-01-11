import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../ui_elements/colors.dart';
import '../../widgets/app_bar.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: const MyAppBar2(
        title: "Notification",
        page: "notification",
      ),
      body: ListView(
        children: [
          notifyItem(),
          notifyItem(),
          notifyItem(),
        ],
      ),
    );
  }

  Widget notifyItem() {
    return Card(
      color: kCardBackgroundColor,
      child: ListTile(
        leading: SizedBox(
            height: double.infinity,
            width: 20.sp,
            child: const Center(child: Icon(Icons.notifications_outlined))),
        title: const Text("New Offers"),
        subtitle: const Text(
            "New Offers Available on this festive season. New Offers Available on this festive season. New Offers Available on this festive season. "),
      ),
    );
  }
}
