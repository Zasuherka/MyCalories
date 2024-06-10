import 'package:app1/internal/bloc/eating_food_bloc/eating_food_bloc.dart';
import 'package:app1/internal/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PFCChart extends StatelessWidget {

  final String title;
  const PFCChart({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    double goalValue = 100;
    double value = 0;
    double counter = 0;
    return GestureDetector(
      onTap: () => context.router.push(const GoalRoute()),
      child: BlocBuilder<EatingFoodBloc, EatingFoodState>(
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
              //width: 118,
              height: 155,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.elementColor,
                  boxShadow: boxShadow,
                  borderRadius: BorderRadius.circular(20.0)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  SizedBox(
                    width: 64,
                    height: 64,
                    child:
                    Stack(
                      children: [
                        Center(
                          child:
                          PieChart
                            (
                              PieChartData(
                                  sectionsSpace: 4,
                                  startDegreeOffset : 270,
                                  centerSpaceRadius: 28,
                                  centerSpaceColor: Colors.transparent,
                                  borderData: FlBorderData(show: false),
                                  sections: [
                                    PieChartSectionData
                                      (
                                        title: '',
                                        radius: 12,
                                        value: value,
                                        color: AppColors.turquoise
                                    ),
                                    PieChartSectionData
                                      (
                                        title: '',
                                        radius: 12,
                                        value: counter,
                                        color: AppColors.red
                                    ),
                                  ]
                              ),
                              swapAnimationDuration: animationDurationLong
                          ),
                        ),
                        Center(
                          child:
                          Text(
                            '${value ~/ (goalValue / 100)}%',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.secondaryTextColor
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 2),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall
                  ),
                  const Spacer(),
                  Text(
                    '${value.toInt()}/${goalValue.toInt()}',
                    // style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    //     color: AppColors.textColor
                    // ),
                  ),
                  const Spacer(),
                ],
              )
          );
        },
      ),
    );
  }
}