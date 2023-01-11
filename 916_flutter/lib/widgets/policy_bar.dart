import 'package:flutter/material.dart';
import 'package:flutter_gold/ui_elements/colors.dart';
import 'package:sizer/sizer.dart';

class PolicyBar extends StatelessWidget {
  const PolicyBar({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Card(
      color: kCardBackgroundColor,
      elevation: 8.0,
      shape: const StadiumBorder(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 10),
            PolicyItem(
              width: width,
              text: 'BIS Hallmarked Jewellery',
            ),
            const SizedBox(height: 40, child: VerticalDivider()),
            PolicyItem(
              width: width,
              text: "Cash / Card on Delivery",
            ),
            const SizedBox(height: 40, child: VerticalDivider()),
            PolicyItem(
              width: width,
              text: "Liftime Exchange",
            ),
            const SizedBox(height: 40, child: VerticalDivider()),
            PolicyItem(
              width: width,
              text: "30 days Return Policy",
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}

class PolicyItem extends StatelessWidget {
  const PolicyItem({super.key, required this.width, required this.text});
  final double width;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width / 4 - 25.sp,
      height: 50,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 9.sp),
        ),
      ),
    );
  }
}


// class PolicyBar2 extends StatelessWidget {
//   const PolicyBar2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     return Card(
//       color: kCardBackgroundColor,
//       elevation: 8.0,
//       shape: const StadiumBorder(),
//       child: Padding(
//         padding: const EdgeInsets.only(top: 8.0, bottom: 5.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             PolicyItem2(
//               width: width,
//               icon: "assets/image/bis.jpg",
//               text: 'BIS Hallmarked Jewellery',
//             ),
//             PolicyItem2(
//               width: width,
//               icon: Icons.payments_outlined,
//               text: "Cash / Card on Delivery",
//             ),
//             PolicyItem2(
//               width: width,
//               icon: Icons.recycling_outlined,
//               text: "Liftime Exchange",
//             ),
//             PolicyItem2(
//               width: width,
//               icon: Icons.assignment_return_outlined,
//               text: "30 days Return Policy",
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PolicyItem2 extends StatelessWidget {
//   const PolicyItem2(
//       {super.key, required this.width, required this.icon, required this.text});
//   final double width;
//   final dynamic icon;
//   final String text;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width / 4 - 10,
//       child: Column(
//         children: [
//           ClipRRect(
//             borderRadius: const BorderRadius.all(Radius.circular(8)),
//             child: Container(
//               width: 30,
//               height: 30,
//               decoration: const BoxDecoration(
//                 color: kWhite,
//                 borderRadius: BorderRadius.all(Radius.circular(8)),
//               ),
//               child: (icon.runtimeType == String)
//                   ? Image.asset(icon)
//                   : Icon(
//                       icon,
//                       color: kLightBlue,
//                     ),
//             ),
//           ),
//           Text(
//             text,
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }
