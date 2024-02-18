import 'package:app1/bloc/eating_food_bloc/eating_food_bloc.dart';
import 'package:app1/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:app1/constants.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PFCChart extends StatelessWidget {

  final String title;
  const PFCChart({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    const Color  = AppColors.white;
    double goalValue = 100;
    double value = 0;
    double counter = 0;
    return BlocBuilder<EatingFoodBloc, EatingFoodState>(
      builder: (context, state) {
        final eatingFoodRead = context.read<EatingFoodBloc>();
        if (title == 'БЕЛКИ'){
          value = eatingFoodRead.allProtein;
        }
        if (title == 'ЖИРЫ'){
          value = eatingFoodRead.allFats;
        }
        if (title == 'УГЛЕВОДЫ'){
          value = eatingFoodRead.allCarbohydrates;
        }
        final localUser = context.read<UserInfoBloc>().localUser;
        if(localUser != null){
          if (title == 'БЕЛКИ'){
            goalValue = localUser.proteinGoal?.toDouble() ?? 100;
          }
          if (title == 'ЖИРЫ'){
            goalValue = localUser.fatsGoal?.toDouble() ?? 100;
          }
          if (title == 'УГЛЕВОДЫ'){
            goalValue = localUser.carbohydratesGoal?.toDouble() ?? 100;
          }
        }
        counter = goalValue - value;
        if (counter <= 0){
          counter = 0;
        }
        return Container(
            width: screenWidth * 0.3,
            height: screenWidth * 0.4,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColors.elementColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(-2, 2),
                  ),
                ],
                borderRadius: BorderRadius.circular(20.0)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
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
                                centerSpaceColor: Colors.transparent,
                                borderData: FlBorderData(show: false),
                                sections: [
                                  PieChartSectionData
                                    (
                                      title: '',
                                      radius: screenWidth * 0.03,
                                      value: value,
                                      color: AppColors.turquoise
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
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textColor
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 2),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.textColor
                  ),
                ),
                const Spacer(),
                Text(
                  '${value.toInt()}/${goalValue.toInt()}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textColor
                  ),
                ),
                const Spacer(),
              ],
            )
        );
      },
    );
  }
}