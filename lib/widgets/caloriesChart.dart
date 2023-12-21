import 'package:app1/bloc/eatingFood/eating_food_bloc.dart';
import 'package:app1/bloc/userImage/user_image_bloc.dart';
import 'package:app1/bloc/userInfo/user_info_bloc.dart';
import 'package:app1/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CaloriesChart extends StatefulWidget {
  const CaloriesChart({super.key});

  @override
  State<CaloriesChart> createState() => _CaloriesChartState();
}

class _CaloriesChartState extends State<CaloriesChart> {
  double value = 0;
  double goalValue = 1000;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     
    return Builder(
        builder: (context){
          final EatingFoodState stateEatingFood = context.watch<EatingFoodBloc>().state;
          final UserInfoState stateUserInfo = context.watch<UserInfoBloc>().state;
          if(stateEatingFood is GetEatingFoodListState || stateEatingFood is EatingFoodInitialState){
            value = stateEatingFood.eatingValues['КАЛОРИИ']!;
          }
          if(stateUserInfo is LocalUserInfoState){
            goalValue = stateUserInfo.appUser.caloriesGoal?.toDouble() ?? 1000;
          }
      return Container(
        width: screenWidth * 0.95,
        height: screenHeight * 0.08,
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
            borderRadius: BorderRadius.circular(25.0)
        ),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(left: screenWidth * 0.075)),
                Text(
                  'КАЛОРИИ: ${value.toInt()}/${goalValue.toInt()}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            Container(
                width: screenWidth * 0.85,
                height: screenHeight * 0.03,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                ),
                child:
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: value / goalValue, // Здесь вычисляем процент заполнения
                    backgroundColor: AppColors.red, // Цвет фона
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.green),
                    // Цвет заполнения
                  ),
                )
            )
          ],
        ),
      );
    });
  }
}
