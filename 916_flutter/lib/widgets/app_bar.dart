import 'package:flutter/material.dart';
import 'package:flutter_gold/screens/cart.dart';
import 'package:sizer/sizer.dart';

import '../screens/notification.dart';
import '../ui_elements/colors.dart';

// AppBar myAppBar(String title) {
//   return AppBar(
//     elevation: 0.0,
//     backgroundColor: kBackgroundColor,
//     // title: Text(
//     //   title,
//     //   style: const TextStyle(color: Colors.orange),
//     // ),
//     title: (title == "")
//         ? SizedBox(width: 230, child: Image.asset("assets/image/916logo.png"))
//         : Text(title),
//     actions: [
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: GestureDetector(
//           child: const Icon(
//             Icons.shopping_cart_outlined,
//             color: kText2,
//           ),
//         ),
//       ),
//       const Padding(
//         padding: EdgeInsets.all(8.0),
//         child: Icon(
//           Icons.notifications_none_outlined,
//           color: kText2,
//         ),
//       ),
//     ],
//   );
// }

class MyAppBar2 extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar2({super.key, required this.title, this.page});
  final String title;
  final String? page;

  @override
  State<MyAppBar2> createState() => _MyAppBar2State();
  @override
  Size get preferredSize => Size.fromHeight(30.sp);
}

class _MyAppBar2State extends State<MyAppBar2> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: kBackgroundColor,
      // title: Text(
      //   title,
      //   style: const TextStyle(color: Colors.orange),
      // ),
      title: (widget.title == "")
          ? SizedBox(
              height: 30.sp, child: Image.asset("assets/image/916logo.png"))
          : Text(widget.title),
      actions: [
        (widget.page == "cart")
            ? Container()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartPage(),
                          ));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartPage(),
                          ));
                    }
                  },
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: kText2,
                  ),
                ),
              ),
        (widget.page == "notification")
            ? Container()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationPage(),
                          ));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationPage(),
                          ));
                    }
                  },
                  child: const Icon(
                    Icons.notifications_none_outlined,
                    color: kText2,
                  ),
                ),
              ),
      ],
    );
  }
}
