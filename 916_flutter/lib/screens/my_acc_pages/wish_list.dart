import 'package:flutter/material.dart';
import 'package:flutter_gold/widgets/textfield.dart';
import 'package:sizer/sizer.dart';

import '../../ui_elements/colors.dart';
import '../../widgets/app_bar.dart';

class WishList extends StatelessWidget {
  const WishList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: const MyAppBar2(
        title: "Wish List",
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [],
        ),
      ),
    );
  }
}
