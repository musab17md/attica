import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../ui_elements.dart/colors.dart';

class PercentageCard extends StatelessWidget {
  const PercentageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: kCardBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Circle Percentage
                CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 20.0,
                  percent: 0.8,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "80%",
                        style: TextStyle(fontSize: 26, color: Colors.white),
                      ),
                      Text(
                        "Percent",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                  progressColor: Colors.green,
                ),
                // Container(
                //   height: 150,
                //   width: 150,
                //   decoration: BoxDecoration(
                //       border: Border.all(color: Colors.grey, width: 30),
                //       borderRadius: BorderRadius.circular(75)),
                //   child: Center(
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: const [
                //         Text(
                //           "90%",
                //           style: TextStyle(
                //               fontSize: 26, color: Colors.white),
                //         ),
                //         Text(
                //           "Present",
                //           style: TextStyle(
                //               fontSize: 18, color: Colors.grey),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Att / Skipped / Reload
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 7),
                                height: 16,
                                width: 16,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                ),
                              ),
                              const Text(
                                "Attended",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 7),
                                height: 16,
                                width: 16,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16)),
                                ),
                              ),
                              const Text(
                                "Skipped",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),
                    Container(
                      decoration: const BoxDecoration(
                          // color: Colors.amber,
                          // border: Border.all(color: Colors.blue),
                          ),
                      child: Center(
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.indigo[400],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: const Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "You're Attendance!",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
