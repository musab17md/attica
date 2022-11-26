import 'package:flutter/material.dart';

class GraphView extends StatelessWidget {
  const GraphView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // decoration: BoxDecoration(
      //   color: Colors.grey[800],
      // ),
      width: double.infinity,
      height: 300,
      child: Stack(
        children: [
          Container(
            child: Column(
              children: const [
                GraphColumn(amt: "400"),
                GraphColumn(amt: "200"),
                GraphColumn(amt: "100"),
                GraphColumn(amt: "50"),
                GraphColumn(amt: "0"),
              ],
            ),
          ),
          Container(
            // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
            child: Column(
              children: [
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      width: 40,
                    ),
                    GraphRow(
                      month: 'Jun 19',
                      lineHeight1: 70,
                      lineHeight2: 140,
                    ),
                    GraphRow(
                      month: 'Jul 19',
                      lineHeight1: 85,
                      lineHeight2: 125,
                    ),
                    GraphRow(
                      month: 'Aug 19',
                      lineHeight1: 95,
                      lineHeight2: 105,
                    ),
                    GraphRow(
                      month: 'Sep 19',
                      lineHeight1: 105,
                      lineHeight2: 120,
                    ),
                    GraphRow(
                      month: 'Oct 19',
                      lineHeight1: 115,
                      lineHeight2: 85,
                    ),
                    GraphRow(
                      month: 'Nov 19',
                      lineHeight1: 80,
                      lineHeight2: 60,
                    ),
                  ],
                ),
                SizedBox(
                  // decoration:
                  //     BoxDecoration(border: Border.all(color: Colors.blue)),
                  height: 90 - 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          color: Color.fromARGB(255, 232, 80, 92),
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      const Text(
                        "Listed",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          color: Colors.blue[700],
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      const Text(
                        "Sold",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GraphRow extends StatelessWidget {
  GraphRow(
      {super.key,
      required this.month,
      required this.lineHeight1,
      required this.lineHeight2});
  final String month;
  final double lineHeight1;
  final double lineHeight2;

  double lineWidth = 12;
  double lineRadius = 8;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //graph
              Container(
                width: lineWidth,
                height: lineHeight1,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 232, 80, 92),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(lineRadius),
                    topRight: Radius.circular(lineRadius),
                  ),
                ),
              ),
              Container(
                width: lineWidth,
                height: lineHeight2,
                decoration: BoxDecoration(
                  color: Colors.blue[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(lineRadius),
                    topRight: Radius.circular(lineRadius),
                  ),
                ),
              ),
            ],
          ),
          //months
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              width: 50,
              child: Text(
                month,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GraphColumn extends StatelessWidget {
  const GraphColumn({super.key, required this.amt});
  final String amt;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            SizedBox(
              width: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  amt,
                  style: const TextStyle(color: Colors.grey),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            const Spacer(),
            Container(
              width: MediaQuery.of(context).size.width - 80,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
