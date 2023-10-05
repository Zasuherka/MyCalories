import 'package:app1/widgets/caloriesChart.dart';
import 'package:app1/widgets/pfcChart.dart';
import 'package:flutter/material.dart';

class MyCalories extends StatefulWidget {
  const MyCalories({super.key});

  @override
  State<MyCalories> createState() => _MyCaloriesState();
}

class _MyCaloriesState extends State<MyCalories> {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 238, 238, 1.0),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: screenHeight/20),
          child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: screenWidth * 0.025),
                        child: PFCChart(value: '31', goalValue: '100', title: 'БЕЛКИ')
                    ),
                    Padding(padding: EdgeInsets.only(left: screenWidth * 0.025),
                        child: PFCChart(value: '31.5', goalValue: '100', title: 'ЖИРЫ')
                    ),
                    Padding(padding: EdgeInsets.only(left: screenWidth * 0.025),
                        child: PFCChart(value: '31', goalValue: '100', title: 'УГЛЕВОДЫ')
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: screenHeight/75)),
                CaloriesChart(value: '35', goalValue: '100'),
                
              ],
            )
          )
        ],
      ),
    );
  }
}
