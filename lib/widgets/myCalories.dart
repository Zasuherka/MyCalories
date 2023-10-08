import 'package:app1/service/UserSirvice.dart';
import 'package:app1/service/foodService.dart';
import 'package:app1/widgets/caloriesChart.dart';
import 'package:app1/widgets/eatingWidget.dart';
import 'package:app1/widgets/pfcChart.dart';
import 'package:flutter/material.dart';

class MyCalories extends StatefulWidget {
  const MyCalories({super.key});

  @override
  State<MyCalories> createState() => _MyCaloriesState();
}

class _MyCaloriesState extends State<MyCalories> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 238, 238, 1.0),
      body:
      SingleChildScrollView(
        child: Column(
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
                            child: PFCChart(goalValue: 210, title: 'БЕЛКИ')
                        ),
                        Padding(padding: EdgeInsets.only(left: screenWidth * 0.025),
                            child: PFCChart(goalValue: 100, title: 'ЖИРЫ')
                        ),
                        Padding(padding: EdgeInsets.only(left: screenWidth * 0.025),
                            child: PFCChart(goalValue: 80, title: 'УГЛЕВОДЫ')
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: screenHeight/75)),
                    CaloriesChart(value: '35', goalValue: '100'),
                    Padding(padding: EdgeInsets.only(top: screenHeight/75)),
                    EatingWidget(title: 'Завтрак', calories: 75, list: localUser!.eatingBreakfast,),
                    Padding(padding: EdgeInsets.only(top: screenHeight/100)),
                    ///TODO изменить значение lenghtList
                    EatingWidget(title: 'Обед', calories: 75, list: localUser!.eatingLunch),
                    Padding(padding: EdgeInsets.only(top: screenHeight/100)),
                    ///TODO изменить значение lenghtList
                    EatingWidget(title: 'Ужин', calories: 7005, list: localUser!.eatingDinner),
                    ///TODO изменить значение lenghtList
                    Padding(padding: EdgeInsets.only(top: screenHeight/100)),
                    EatingWidget(title: 'Другое', calories: 75, list: localUser!.eatingAnother),
                    Padding(padding: EdgeInsets.only(top: screenHeight/100)),

                  ],
                )
            )
          ],
        ),
      )
    );
  }
}
