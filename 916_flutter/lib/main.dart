import 'package:flutter/material.dart';
import 'package:flutter_gold/screens/enter_mpin.dart';
import 'package:flutter_gold/screens/jewellery.dart';
import 'package:flutter_gold/screens/locker.dart';
import 'package:flutter_gold/screens/login.dart';
import 'package:flutter_gold/screens/my_account.dart';
import 'package:flutter_gold/ui_elements/my_provider.dart';
import 'package:flutter_gold/ui_elements/widget_style.dart';
import 'package:flutter_gold/widgets/app_bar.dart';
import 'package:flutter_gold/widgets/best_offers.dart';
import 'package:flutter_gold/widgets/buy_sell_tab.dart';
import 'package:flutter_gold/widgets/carousel.dart';
import 'package:flutter_gold/widgets/customer_review.dart';
import 'package:flutter_gold/widgets/magazine.dart';
import 'package:flutter_gold/widgets/policy_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/coin_bar.dart';
import 'ui_elements/colors.dart';
import 'widgets/live_text_card.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MyProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String>? cred;

  logInUser() async {
    final prefs = await SharedPreferences.getInstance();
    cred = prefs.getStringList('credentials');
    if (cred == null) {
      debugPrint("logInUser: cred is null");
      return "login";
    }
    if (cred![1] != "") {
      debugPrint("logInUser: cred has mpin saved");
      debugPrint(cred![1]);
      return "mpin";
    }
    // API call here Check if number is active
    if (cred![0] != "") {
      debugPrint("logInUser: ${cred![0]} logged in user!");
      return "home";
    } else {
      debugPrint("logInUser: cred not matched");
      return "login";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return MaterialApp(
          theme: _buildTheme(Brightness.dark),
          debugShowCheckedModeBanner: false,
          title: '916 Digital Gold',
          home: FutureBuilder(
            future: logInUser(),
            builder: (context, snapshot) {
              if (snapshot.data == "home") {
                return const MyHomePage();
              }
              if (snapshot.data == "login") {
                return const LoginPage();
              }
              if (snapshot.data == "mpin") {
                return EnterMpin(pin: cred![1]);
              }
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

ThemeData _buildTheme(brightness) {
  double spacing = 1.2;
  var baseTheme = ThemeData(
    brightness: brightness,
    textTheme: TextTheme(
      // displayLarge: TextStyle(letterSpacing: spacing),
      // displayMedium: TextStyle(letterSpacing: spacing),
      // displaySmall: TextStyle(letterSpacing: spacing),
      headlineLarge: TextStyle(letterSpacing: spacing),
      // headlineMedium: TextStyle(letterSpacing: spacing),
      // headlineSmall: TextStyle(letterSpacing: spacing),
      // titleLarge: TextStyle(letterSpacing: spacing),
      // titleMedium: TextStyle(letterSpacing: spacing),
      // titleSmall: TextStyle(letterSpacing: spacing),
      // bodyLarge: TextStyle(letterSpacing: spacing),
      // bodyMedium: TextStyle(letterSpacing: spacing),
      // bodySmall: TextStyle(letterSpacing: spacing),
      // labelLarge: TextStyle(letterSpacing: spacing),
      // labelMedium: TextStyle(letterSpacing: spacing),
      // labelSmall: TextStyle(letterSpacing: spacing),
      headline1: TextStyle(letterSpacing: spacing),
      headline2: TextStyle(letterSpacing: spacing),
      headline3: TextStyle(letterSpacing: spacing),
      headline4: TextStyle(letterSpacing: spacing),
      headline5: TextStyle(letterSpacing: spacing),
      headline6: TextStyle(letterSpacing: spacing),
      subtitle1: TextStyle(letterSpacing: spacing),
      subtitle2: TextStyle(letterSpacing: spacing),
      bodyText1: TextStyle(letterSpacing: spacing),
      bodyText2: TextStyle(letterSpacing: spacing),
      caption: TextStyle(letterSpacing: spacing),
      button: TextStyle(letterSpacing: spacing),
      overline: TextStyle(letterSpacing: spacing),
    ),
  );

  return baseTheme.copyWith(
    textTheme: GoogleFonts.bebasNeueTextTheme(baseTheme.textTheme),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int pageIndex = 0;
  final pages = [
    const HomePage(),
    const CoinBarPage(),
    const JewelleryPage(),
    const MyLocker(),
    const MyAccount(),
  ];

  void _onItemTapped(int index) {
    // setState(() {
    //   pageIndex = index;
    // });
    context.read<MyProvider>().pageIndex(index);
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: kCardBackgroundColor,
              title: const Text('Confirm'),
              content: const Text('Do you want to exit the App?'),
              actions: [
                MyButton(
                  child: const Text('No'),
                  onPressFunc: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                MyButton(
                  child: const Text('Yes'),
                  onPressFunc: () {
                    Navigator.of(context).pop(true);
                    // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                )
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double cardWidth = (width / 2) - 16;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: const MyAppBar2(
          title: '',
        ),
        body: pages[context.watch<MyProvider>().page],
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 15.0,
                  offset: Offset(0.0, 0.75))
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: kCardBackgroundColor,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.paid_outlined), label: "Gold Coin/Bar"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.local_mall_outlined), label: "Jewellery"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.lock_outlined), label: "Digital Locker"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), label: "My Account"),
            ],
            currentIndex: context.watch<MyProvider>().page,
            selectedItemColor: kWhite,
            onTap: _onItemTapped,
            selectedFontSize: 8.0.sp,
            unselectedFontSize: 6.0.sp,
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double cardWidth = (width / 2) - 16;
    return SingleChildScrollView(
      child: Column(
        children: const [
          SizedBox(height: 0),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: const [
          // LiveTextCard(
          //     cardWidth: cardWidth,
          //     text: "Live Gold Rate",
          //     amount: "$goldRate/-"),
          // LiveTextCard(
          //     cardWidth: cardWidth,
          //     text: "Live Silver Rate",
          //     amount: "$silverRate/-"),
          // LiveTextCard2(
          //     cardWidth: cardWidth,
          //     text: "Live Gold Rate",
          //     amount: "$goldRate/-"),
          // LiveTextCard2(
          //     cardWidth: cardWidth,
          //     text: "Live Silver Rate",
          //     amount: "$silverRate/-"),
          //   ],
          // ),
          LiveTextCard3(),
          SizedBox(height: 0),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
            child: BuySellTab2(isSell: false),
          ),
          SizedBox(height: 8),
          MyCarousel(),
          SizedBox(height: 6),
          PolicyBar(),
          SizedBox(height: 10),
          BestOffers(),
          Magazine(),
          SizedBox(height: 30),
          CustomerReview(),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
