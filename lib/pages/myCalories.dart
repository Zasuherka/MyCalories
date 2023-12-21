import 'package:app1/bloc/userInfo/user_info_bloc.dart';
import 'package:app1/constants.dart';
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
    BlocProvider.of<UserInfoBloc>(context).add(LocalUserInfoEvent());
  }

  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body:
      SingleChildScrollView(
        child:Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + screenHeight/200),
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: screenWidth * 0.025),
                        child: const PFCChart(title: 'БЕЛКИ')
                    ),
                    Padding(padding: EdgeInsets.only(left: screenWidth * 0.025),
                        child: const PFCChart(title: 'ЖИРЫ')
                    ),
                    Padding(padding: EdgeInsets.only(left: screenWidth * 0.025),
                        child: const PFCChart(title: 'УГЛЕВОДЫ')
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
              ],
            )
        )
      )
    );
  }
}
