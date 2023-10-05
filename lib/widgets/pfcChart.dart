import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PFCChart extends StatefulWidget {

  final String goalValue;
  final String value;
  final String title;
  const PFCChart({super.key, required this.value, required this.goalValue, required this.title});

  @override
  State<PFCChart> createState() => _PFCChartState();
}

class _PFCChartState extends State<PFCChart> {
  late String title;
  late double value;
  late double goalValue;
  late int percent;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = widget.title;
    value = double.parse(widget.value);
    goalValue = double.parse(widget.goalValue);
    percent = value ~/ (goalValue / 100);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
        width: screenWidth * 0.3,
        height: screenWidth * 0.4,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 13,
                offset: const Offset(10, 10),
              ),
            ],
            // border: Border.all(color: const Color.fromRGBO(16, 240, 12, 1.0),
            //     width: 4
            // ),
            borderRadius: BorderRadius.circular(20.0)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: screenWidth * 0.16,
              height: screenWidth * 0.160,
              child:
              Stack(
                children: [
                  Center(
                    child:
                    PieChart
                      (
                        PieChartData(
                            sectionsSpace: screenWidth/100,
                            startDegreeOffset : 270,
                            centerSpaceRadius: screenWidth * 0.07,
                            centerSpaceColor: Colors.white,
                            borderData: FlBorderData(show: false),
                            sections: [
                              PieChartSectionData
                                (
                                  title: '',
                                  radius: screenWidth * 0.03,
                                  value: value,
                                  color: const Color.fromRGBO(16, 240, 12, 1.0)
                              ),
                              PieChartSectionData
                                (
                                  title: '',
                                  radius: screenWidth * 0.03,
                                  value: goalValue - value,
                                  color: const Color.fromRGBO(255, 0, 13, 1.0)
                              ),

                            ]
                        )
                    ),
                  ),
                  Center(
                    child:
                    Text(
                      '$percent%',
                      style: TextStyle(
                        fontSize: screenHeight/77,
                        fontFamily: 'Comfortaa',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: screenHeight/60),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: screenHeight/50,
                  fontFamily: 'Comfortaa',
                  color: Colors.black,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: screenHeight/160),
              child:
              Text(
                '${value.toInt()}/${goalValue.toInt()}',
                style: TextStyle(
                  fontSize: screenHeight/60,
                  fontFamily: 'Comfortaa',
                  color: Colors.black,
                ),
              ),
            )
          ],
        )
    );
  }
}