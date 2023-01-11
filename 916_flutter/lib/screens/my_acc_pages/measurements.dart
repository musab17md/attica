import 'package:flutter/material.dart';
import 'package:flutter_gold/ui_elements/widget_style.dart';
import 'package:flutter_gold/widgets/textfield.dart';
import 'package:sizer/sizer.dart';

import '../../ui_elements/colors.dart';
import '../../widgets/app_bar.dart';

List myMeasures = [
  ['1', 'Person one', '', '4', ''],
  ['2', 'Person two', '6', '', '4'],
  ['3', 'Person three', '', '5', ''],
  ['4', 'Person four', '3', '3', ''],
  ['5', 'Person five', '', '4', '6'],
];

class MyMeasurments extends StatelessWidget {
  const MyMeasurments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: const MyAppBar2(
        title: "Measurments",
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Wrap(
                children: [
                  for (var i in myMeasures)
                    AddPills(
                      measures: i,
                    ),
                ],
              ),
              MyButton(
                  onPressFunc: () {
                    showDialog(
                      context: context,
                      builder: (context) => const AddMeasures(),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.add),
                      Text(" Add Measurement"),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class AddPills extends StatelessWidget {
  const AddPills({super.key, required this.measures});
  final List measures;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddMeasures(
                measure: measures,
              );
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 5.0,
                    offset: Offset(0.0, 0.75))
              ],
              color: kButton,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 5.sp),
                Text(
                  measures[1],
                  style: TextStyle(fontSize: 8.sp, color: kButtonText),
                ),
                SizedBox(width: 5.sp),
                Icon(
                  Icons.edit,
                  color: kButtonText,
                  size: 8.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddMeasures extends StatefulWidget {
  const AddMeasures({super.key, this.measure});
  final List? measure;

  @override
  State<AddMeasures> createState() => _AddMeasuresState();
}

class _AddMeasuresState extends State<AddMeasures> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ringController = TextEditingController();
  TextEditingController bangleController = TextEditingController();
  TextEditingController cuffController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  "Add Measurements",
                  style: TextStyle(fontSize: 15.sp),
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
                  label: "Rings",
                  icon: Icons.diamond,
                  textType: TextInputType.number,
                  obscureTxt: false,
                  textControl: ringController,
                ),
                const SizedBox(height: 10),
                TextWidget(
                  label: "Bangles",
                  icon: Icons.diamond,
                  textType: TextInputType.number,
                  obscureTxt: false,
                  textControl: bangleController,
                ),
                const SizedBox(height: 10),
                TextWidget(
                  label: "Cuff",
                  icon: Icons.diamond,
                  textType: TextInputType.number,
                  obscureTxt: false,
                  textControl: cuffController,
                ),
                (widget.measure == null)
                    ? MyButton(
                        onPressFunc: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Save"))
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MyButton(
                              onPressFunc: () {}, child: const Text("Update")),
                          MyButton(
                              onPressFunc: () {}, child: const Text("Delete")),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




            // MyButton(
            //     onPressFunc: () {
            //       showDialog(
            //         context: context,
            //         builder: (context) {
            //           return Scaffold(
            //             backgroundColor: kBackgroundColor,
            //             body: Column(children: [
            //               const Text("Add Measurement"),
            //                 const TextWidget(
            //                     label: "Name",
            //                     icon: Icons.person,
            //                     textType: TextInputType.name,
            //                     obscureTxt: false),
            //               MyButton(
            //                   onPressFunc: () {}, child: const Text("Close")),
            //               MyButton(
            //                   onPressFunc: () {}, child: const Text("Add")),
            //             ],),
            //             ],
            //           );
            //         },
            //       );
            //     },
            //     child: const Text('Add Measurement')),