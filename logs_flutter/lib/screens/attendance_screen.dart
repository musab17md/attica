// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:easy_rich_text/easy_rich_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../ui_elements.dart/colors.dart';
// import '../ui_elements.dart/constants.dart';

// class AttendanceScreen extends StatefulWidget {
//   @override
//   _AttendanceScreenState createState() => _AttendanceScreenState();
// }

// class _AttendanceScreenState extends State<AttendanceScreen> {
//   bool isLoading = false;
//   bool ploading = false;
//   bool hideBanner = false;
//   bool error = false;
//   bool pressed = false;
//   DateTime d = DateTime.now();
//   String? dbImageURL;
//   String? dbImageDataURL;
//   bool showCross = false;
//   String? imageTitle;

//   String getsuperscript(int n) {
//     if (n == 1 || n == 21) {
//       return 'st';
//     } else if (n == 2 || n == 22) {
//       return 'nd';
//     } else if (n == 3 || n == 23) {
//       return 'rd';
//     } else {
//       return 'th';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: kBackgroundColor,
//         title: SizedBox(
//           width: 0.6.sw,
//           child: const Text(
//             'Welcome, Musab',
//             textScaleFactor: 1.0,
//           ),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 20.0),
//             child: GestureDetector(
//               child: const Icon(
//                 Icons.account_circle,
//                 size: 30.0,
//               ),
//               onTap: () {},
//             ),
//           )
//         ],
//       ),
//       body: SafeArea(
//         child: ListView(
//             controller: ScrollController(),
//             physics: const BouncingScrollPhysics(),
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 30.h),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     //TODO container for showing date
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           weekdays[d.weekday],
//                           textScaleFactor: 1,
//                           style: GoogleFonts.questrial(
//                               fontSize: 42.sp, color: Colors.white),
//                         ),
//                         EasyRichText(
//                           "${d.day}${getsuperscript(d.day)} ${months[d.month]}  ${d.year}",
//                           patternList: [
//                             EasyRichTextPattern(
//                               targetString: '${d.day}',
//                               style: GoogleFonts.questrial(
//                                 fontSize: 80.sp,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             EasyRichTextPattern(
//                               targetString: months[d.month],
//                               style: GoogleFonts.questrial(
//                                   fontSize: 60.sp, color: Colors.white),
//                             ),
//                             EasyRichTextPattern(
//                               targetString: '${d.year}',
//                               style: GoogleFonts.questrial(
//                                   fontSize: 60.sp, color: Colors.white),
//                             ),
//                             EasyRichTextPattern(
//                               targetString: getsuperscript(d.day),
//                               superScript: true,
//                               stringBeforeTarget: '${d.day}',
//                               matchWordBoundaries: false,
//                               style: GoogleFonts.questrial(
//                                 color: Colors.white,
//                                 fontSize: 60.sp,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 30.h,
//                     ),
//                     if (hideBanner == false && dbImageURL != null)
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Stack(
//                             children: [
//                               Container(
//                                 margin: EdgeInsets.symmetric(vertical: 30.h),
//                                 child: GestureDetector(
//                                   onTap: () async {},
//                                   child: AspectRatio(
//                                     aspectRatio: 22 / 9,
//                                     child: ClipRRect(
//                                       borderRadius:
//                                           BorderRadius.circular(15), // Ima
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(15.0),
//                                           color: kCardBackgroundColor,
//                                         ),
//                                         child: CachedNetworkImage(
//                                           imageUrl: dbImageURL ?? '',
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               if (showCross)
//                                 Align(
//                                   alignment: Alignment.topRight,
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         hideBanner = true;
//                                       });
//                                     },
//                                     child: const Icon(
//                                       Icons.cancel,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 )
//                             ],
//                           ),
//                           if (imageTitle != null)
//                             Text(
//                               imageTitle ?? '',
//                               textScaleFactor: 1,
//                               style: GoogleFonts.questrial(
//                                 fontWeight: FontWeight.w500,
//                                 color: kWhite,
//                                 fontSize: 43.sp,
//                               ),
//                             ),
//                         ],
//                       ),

//                     Padding(
//                       padding: EdgeInsets.only(top: 80.h, bottom: 20.h),
//                       child: Text(
//                         ' Overall Attendance',
//                         style: GoogleFonts.questrial(
//                           fontSize: 50.sp,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),

//                     //TODO percentage Card
//                     ((ploading && loginProvider.iserror == false) ||
//                             (loginProvider.isViewAttendance &&
//                                 loginProvider.iserror == false &&
//                                 loginProvider.isSubjecterror == false))
//                         ? const PercentageLoading()
//                         : Percentage(),
//                     //TODO date wise button
//                     FlatButton(
//                       color: Colors.indigo[400],
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           PageRouteBuilder(
//                             pageBuilder: (context, animation1, animation2) =>
//                                 DateWise(),
//                             transitionDuration: const Duration(seconds: 15),
//                           ),
//                         );
//                       },
//                       child: AutoSizeText(
//                         'View Datewise Attendance',
//                         maxLines: 1,
//                         minFontSize: 0,
//                         style: TextStyle(
//                             fontSize: 45.sp,
//                             color: kWhite,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     ),

//                     //TODO subject text
//                     Padding(
//                       padding: EdgeInsets.only(top: 80.h, bottom: 20.h),
//                       child: Text(
//                         ' Subjects',
//                         style: GoogleFonts.questrial(
//                           fontSize: 50.sp,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),

//                     //TODO all subjects cards
//                     (loginProvider.isViewAttendance &&
//                             loginProvider.iserror == false &&
//                             loginProvider.isSubjecterror == false)
//                         ? const Center(
//                             child: CircularProgressIndicator(
//                             color: kLightGreen,
//                           ))
//                         : (isLoading == false)
//                             ? ((error)
//                                 ? Text(
//                                     'Error',
//                                     style: TextStyle(
//                                         fontSize: 50.sp, color: kWhite),
//                                   )
//                                 : SubjectCardBuilder())
//                             : const Center(
//                                 child: CircularProgressIndicator(
//                                 color: kLightGreen,
//                               )),

//                     const SizedBox(
//                       height: 20.0,
//                     ),
//                   ],
//                 ),
//               ),
//             ]),
//       ),
//     );
//   }
// }
