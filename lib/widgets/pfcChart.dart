import 'package:app1/bloc/eatingFood/eating_food_bloc.dart';
import 'package:app1/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PFCChart extends StatefulWidget {

  final double goalValue;
  final String title;
  const PFCChart({super.key, required this.goalValue, required this.title});

  @override
  State<PFCChart> createState() => _PFCChartState();
}

class _PFCChartState extends State<PFCChart> {
  late String title;
  late double goalValue;
  double value = 0;
  double counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = widget.title;
    goalValue = widget.goalValue;

  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<EatingFoodBloc, EatingFoodState>(
      builder: (context, state) {
        if(state is GetEatingFoodListState || state is EatingFoodInitialState){
          value = state.eatingValues[title]!;
          counter = goalValue - value;
          if (counter <= 0){
            counter = 0;
          }
        }
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
                                      color: AppColors.green
                                  ),
                                  PieChartSectionData
                                    (
                                      title: '',
                                      radius: screenWidth * 0.03,
                                      value: counter,
                                      color: AppColors.red
                                  ),

                                ]
                            )
                        ),
                      ),
                      Center(
                        child:
                        Text(
                          '${value ~/ (goalValue / 100)}%',
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
      },
    );
  }
}