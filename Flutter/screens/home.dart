import 'dart:io';
import 'dart:math' as math;
import 'package:ecom/constant/navbar.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  static const _actionTitles = ['Create Post', 'Upload Photo', 'Upload Video'];

  void _showAction(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(_actionTitles[index]),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  List myList = [
    "",
    "",
    "",
    "0",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "Vendor",
    "02-11-2022",
    "Image 5",
    "Pending",
    "",
    ""
  ];

  getLastEntry() async {
    var res = await SharedPreferences.getInstance()
            .then((value) => value.getStringList("last_post")) ??
        myList;
    debugPrint(res.toString());
    debugPrint(res[0]);
    myList = res;

    return res;
  }

  List myRate = [
    "",
    "",
    "",
    "",
  ];

  List myUpload = [
    "",
    "",
    "",
    "",
  ];

  getLastRate() async {
    var res = await SharedPreferences.getInstance()
        .then((value) => value.getStringList("last_rate"));
    var res2 = await SharedPreferences.getInstance()
        .then((value) => value.getStringList("last_image"));
    myRate = res ?? myRate;
    myUpload = res2 ?? myUpload;
    return res;
  }

  getImage(path) {
    var fullPath = "/data/user/0/com.example.ecom/app_flutter/$path";
    if (File(fullPath).existsSync()) {
      return Image.file(
        File(fullPath),
        // width: (width / 2) - 30,
      );
    }
    return Image.asset(
      "assets/placeholder.jpg",
      // width: (width / 2) - 30,
    );
  }

  getVideo(path) {
    var fullPath = "/data/user/0/com.example.ecom/app_flutter/$path";
    if (File(fullPath).existsSync()) {
      return Image.asset(
        "assets/video.png",
        // width: (width / 2) - 30,
      );
    }
    return Image.asset(
      "assets/placeholder.jpg",
      // width: (width / 2) - 30,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: const NavDraw(),
      appBar: AppBar(
        title: const Text("916 Digital Gold"),
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(content: Text("Tab back again to leave")),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              FutureBuilder(
                  future: getLastEntry(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container();
                    }
                    if (snapshot.hasData) {
                      return Card(
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            const Text(
                              "Last Product Preview",
                              style: TextStyle(fontSize: 30.0),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: DataTable(
                                columns: const <DataColumn>[
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'Title',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'Description',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                ],
                                rows: <DataRow>[
                                  DataRow(
                                    cells: <DataCell>[
                                      const DataCell(Text("Metal")),
                                      DataCell(Text(myList[0])),
                                    ],
                                  ),
                                  DataRow(
                                    cells: <DataCell>[
                                      const DataCell(Text('Ornament')),
                                      DataCell(Text(myList[1])),
                                    ],
                                  ),
                                  DataRow(
                                    cells: <DataCell>[
                                      const DataCell(Text('Purity %')),
                                      DataCell(Text(myList[2])),
                                    ],
                                  ),
                                  DataRow(
                                    cells: <DataCell>[
                                      const DataCell(Text('24K Rate')),
                                      DataCell(Text(myList[3])),
                                    ],
                                  ),
                                  DataRow(
                                    cells: <DataCell>[
                                      const DataCell(Text('Gross Weight')),
                                      DataCell(Text(myList[4])),
                                    ],
                                  ),
                                  DataRow(
                                    cells: <DataCell>[
                                      const DataCell(Text('Stone Weight')),
                                      DataCell(Text(myList[5])),
                                    ],
                                  ),
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text(
                                          'Making Charges ${myList[18]}%')),
                                      DataCell(Text(myList[6])),
                                    ],
                                  ),
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text(
                                          'Wastage Charges ${myList[19]}%')),
                                      DataCell(Text(myList[7])),
                                    ],
                                  ),
                                  DataRow(
                                    cells: <DataCell>[
                                      const DataCell(Text('Stone Charges ₹')),
                                      DataCell(Text(myList[8])),
                                    ],
                                  ),
                                  DataRow(
                                    cells: <DataCell>[
                                      const DataCell(Text('Net Weight')),
                                      DataCell(Text(myList[9])),
                                    ],
                                  ),
                                  DataRow(
                                    cells: <DataCell>[
                                      const DataCell(Text('Net Amount')),
                                      DataCell(Text(myList[10])),
                                    ],
                                  ),
                                  DataRow(
                                    cells: <DataCell>[
                                      const DataCell(
                                          Text('Total (NA + MC + WC + SC)')),
                                      DataCell(Text(myList[11])),
                                    ],
                                  ),
                                  DataRow(
                                    cells: <DataCell>[
                                      const DataCell(Text('Validity Date')),
                                      DataCell(Text(myList[12])),
                                    ],
                                  ),
                                  DataRow(
                                    cells: <DataCell>[
                                      const DataCell(Text('Quantity')),
                                      DataCell(Text(myList[13])),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Container();
                  }),
              const SizedBox(height: 50),
              FutureBuilder(
                  future: getLastRate(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container();
                    }
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Card(
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                const Text(
                                  "Gold Rate",
                                  style: TextStyle(fontSize: 30.0),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: DataTable(
                                    columns: const <DataColumn>[
                                      DataColumn(
                                        label: Expanded(
                                          child: Text(
                                            'Title',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Expanded(
                                          child: Text(
                                            'Description',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      ),
                                    ],
                                    rows: <DataRow>[
                                      DataRow(
                                        cells: <DataCell>[
                                          const DataCell(Text("Rate")),
                                          DataCell(Row(
                                            children: [
                                              const Icon(
                                                Icons.currency_rupee,
                                                size: 15.0,
                                              ),
                                              Text(myRate[1]),
                                            ],
                                          )),
                                        ],
                                      ),
                                      DataRow(
                                        cells: <DataCell>[
                                          const DataCell(Text('Metal')),
                                          DataCell(Text(myRate[0])),
                                        ],
                                      ),
                                      DataRow(
                                        cells: <DataCell>[
                                          const DataCell(Text('Time')),
                                          DataCell(Text(myRate[2])),
                                        ],
                                      ),
                                      DataRow(
                                        cells: <DataCell>[
                                          const DataCell(Text('Date')),
                                          DataCell(Text(myRate[3])),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 50),
                          Card(
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  const Text(
                                    "Previously Uploaded Images",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: double.infinity,
                                    child: DataTable(
                                      columns: const <DataColumn>[
                                        DataColumn(
                                          label: Expanded(
                                            child: Text(
                                              'Title',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                            child: Text(
                                              'Description',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ),
                                        ),
                                      ],
                                      rows: <DataRow>[
                                        DataRow(
                                          cells: <DataCell>[
                                            const DataCell(Text('Vendor Name')),
                                            DataCell(Text(myUpload[0])),
                                          ],
                                        ),
                                        DataRow(
                                          cells: <DataCell>[
                                            const DataCell(
                                                Text("Ornament Type")),
                                            DataCell(
                                              Text(myUpload[1]),
                                            ),
                                          ],
                                        ),
                                        DataRow(
                                          cells: <DataCell>[
                                            const DataCell(Text('Time')),
                                            DataCell(Text(myUpload[2])),
                                          ],
                                        ),
                                        DataRow(
                                          cells: <DataCell>[
                                            const DataCell(Text('Date')),
                                            DataCell(Text(myUpload[3])),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height: 250,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          scrollImg("ProdPic1.jpg", context),
                                          scrollImg("ProdPic2.jpg", context),
                                          scrollImg("ProdPic3.jpg", context),
                                          scrollVid("ProdVideo.mp4"),
                                          scrollImg("ModalPic1.jpg", context),
                                          scrollImg("ModalPic2.jpg", context),
                                        ],
                                      )),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceEvenly,
                                  //   children: [
                                  //     SizedBox(
                                  //       child: getImage("ProdPic1.jpg", width),
                                  //     ),
                                  //     SizedBox(
                                  //       child: getImage("ProdPic2.jpg", width),
                                  //     ),
                                  //   ],
                                  // ),
                                  // const SizedBox(
                                  //   height: 20,
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceEvenly,
                                  //   children: [
                                  //     SizedBox(
                                  //       child: getImage("ProdPic3.jpg", width),
                                  //     ),
                                  //     SizedBox(
                                  //       child: getVideo("ProdVideo.mp4", width),
                                  //     ),
                                  //   ],
                                  // ),
                                  // const SizedBox(
                                  //   height: 20,
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceEvenly,
                                  //   children: [
                                  //     SizedBox(
                                  //       child: getImage("ModalPic1.jpg", width),
                                  //     ),
                                  //     SizedBox(
                                  //       child: getImage("ModalPic2.jpg", width),
                                  //     ),
                                  //   ],
                                  // ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                        ],
                      );
                    }
                    return Container();
                  }),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     child: const Icon(Icons.add),
      //     onPressed: () {
      //       Navigator.push(context,
      //           MaterialPageRoute(builder: ((context) => const AddProduct3())));
      //     }),
      floatingActionButton: ExpandableFab(
        distance: 112.0,
        children: [
          ActionButton(
            onPressed: () => Navigator.pushNamed(context, '/addImage'),
            icon: const Icon(Icons.image),
          ),
          ActionButton(
            onPressed: () => Navigator.pushNamed(context, '/addGold'),
            icon: const Icon(Icons.currency_rupee),
          ),
          ActionButton(
            onPressed: () => Navigator.pushNamed(context, '/listImage'),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget scrollImg(String name, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => FullImage(
                      name: "/data/user/0/com.example.ecom/app_flutter/$name",
                    ))));
      },
      child: Card(
        elevation: 8.0,
        margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
        child: getImage(name),
      ),
    );
  }

  Widget scrollVid(String name) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
      child: getVideo(name),
    );
  }
}

// SizedBox(
//         width: double.infinity,
//         child: DataTable(
//           columns: const <DataColumn>[
//             DataColumn(
//               label: Expanded(
//                 child: Text(
//                   'Title',
//                   style: TextStyle(fontStyle: FontStyle.italic),
//                 ),
//               ),
//             ),
//             DataColumn(
//               label: Expanded(
//                 child: Text(
//                   'Description',
//                   style: TextStyle(fontStyle: FontStyle.italic),
//                 ),
//               ),
//             ),
//           ],
//           rows: const <DataRow>[
//             DataRow(
//               cells: <DataCell>[
//                 DataCell(Text('Sarah')),
//                 DataCell(Text('19')),
//               ],
//             ),
//             DataRow(
//               cells: <DataCell>[
//                 DataCell(Text('Janine')),
//                 DataCell(Text('43')),
//               ],
//             ),
//             DataRow(
//               cells: <DataCell>[
//                 DataCell(Text('William')),
//                 DataCell(Text('27')),
//               ],
//             ),
//           ],
//         ),
//       ),

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen,
    required this.distance,
    required this.children,
  });

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            child: const Icon(Icons.create),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.secondary,
      elevation: 4.0,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: theme.colorScheme.onSecondary,
      ),
    );
  }
}

class FullImage extends StatelessWidget {
  final name;

  const FullImage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: PhotoView(
        imageProvider: FileImage(File(name)),
      )),
    );
  }
}
