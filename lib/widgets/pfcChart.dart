import 'package:app1/bloc/eatingFood/eating_food_bloc.dart';
import 'package:app1/bloc/userInfo/user_info_bloc.dart';
import 'package:app1/constants.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PFCChart extends StatefulWidget {

  final String title;
  const PFCChart({super.key, required this.title});

  @override
  State<PFCChart> createState() => _PFCChartState();
}

class _PFCChartState extends State<PFCChart> {
  late String title;
  double goalValue = 100;
  double value = 0;
  double counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = widget.title;
    //goalValue = widget.goalValue;
  }

  @override
  Widget build(BuildContext context) {
     
    return Builder(
      builder: (context) {
        final EatingFoodState eatingFoodState = context.watch<EatingFoodBloc>().state;
        final UserInfoState userInfoState = context.watch<UserInfoBloc>().state;
        if(eatingFoodState is GetEatingFoodListState || eatingFoodState is EatingFoodInitialState){
          value = eatingFoodState.eatingValues[title]!;
          counter = goalValue - value;
          if (counter <= 0){
            counter = 0;
          }
        }
        if(userInfoState is LocalUserInfoState){
          if (title == 'БЕЛКИ'){
            goalValue = userInfoState.appUser.proteinGoal?.toDouble() ?? 100;
          }
          if (title == 'ЖИРЫ'){
            goalValue = userInfoState.appUser.fatsGoal?.toDouble() ?? 100;
          }
          if (title == 'УГЛЕВОДЫ'){
            goalValue = userInfoState.appUser.carbohydratesGoal?.toDouble() ?? 100;
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
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: screenHeight/60),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: screenHeight/160),
                  child:
                  Text(
                    '${value.toInt()}/${goalValue.toInt()}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )
              ],
            )
        );
      },
    );
  }
}