import 'package:app1/bloc/foodBloc/food_bloc.dart';
import 'package:app1/pages/authorizationPage.dart';
import 'package:app1/pages/myFoodPage.dart';
import 'package:app1/service/UserSirvice.dart';
import 'package:app1/widgets/caloriesChart.dart';
import 'package:app1/widgets/eatingWidget.dart';
import 'package:app1/widgets/pfcChart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        child:Padding(padding: EdgeInsets.only(top: screenHeight/20),
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: screenWidth * 0.025),
                        child: const PFCChart(goalValue: 210, title: 'БЕЛКИ')
                    ),
                    Padding(padding: EdgeInsets.only(left: screenWidth * 0.025),
                        child: const PFCChart(goalValue: 100, title: 'ЖИРЫ')
                    ),
                    Padding(padding: EdgeInsets.only(left: screenWidth * 0.025),
                        child: const PFCChart(goalValue: 80, title: 'УГЛЕВОДЫ')
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: screenHeight/75)),
                const CaloriesChart(),
                Padding(padding: EdgeInsets.only(top: screenHeight/75)),
                const EatingWidget(title: 'Завтрак'),
                Padding(padding: EdgeInsets.only(top: screenHeight/100)),
                const EatingWidget(title: 'Обед'),
                Padding(padding: EdgeInsets.only(top: screenHeight/100)),
                const EatingWidget(title: 'Ужин'),
                Padding(padding: EdgeInsets.only(top: screenHeight/100)),
                const EatingWidget(title: 'Другое'),
                Padding(padding: EdgeInsets.only(top: screenHeight/100)),
                ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<FoodBloc>(context).add(FoodInitialEvent());
                      Navigator.push(context,MaterialPageRoute(builder: (context) => const MyFoodPage(isUpdatePage: true)));
                    },
                    child: Text(localUser!.name.toString())),
                ElevatedButton(
                  onPressed: () async {
                    await exitUser();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthorizationPage()));
                  },
                  child: const Text('Выход'),
                )

              ],
            )
        )
      )
    );
  }
}
