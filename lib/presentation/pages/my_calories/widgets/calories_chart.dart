import 'package:app1/internal/bloc/eating_food_bloc/eating_food_bloc.dart';
import 'package:app1/internal/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CaloriesChart extends StatefulWidget {
  const CaloriesChart({super.key});

  @override
  State<CaloriesChart> createState() => _CaloriesChartState();
}

class _CaloriesChartState extends State<CaloriesChart> {
  @override
  Widget build(BuildContext context) {
    double value = 0;
    double goalValue = 1000;
    return GestureDetector(
      onTap: () => context.router.push(const GoalRoute()),
      child: BlocBuilder<EatingFoodBloc, EatingFoodState>(
          builder: (context, state){
            value = context.read<EatingFoodBloc>().allCalories;
            goalValue = context.read<UserInfoBloc>().localUser?.caloriesGoal?.toDouble() ?? 1000;
        return Container(
          width: screenWidth,
          height: 70,
          decoration: BoxDecoration(
              color: AppColors.elementColor,
              boxShadow: boxShadow,
              borderRadius: BorderRadius.circular(25.0)
          ),
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                'КАЛОРИИ: ${value.toInt()}/${goalValue.toInt()}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Spacer(),
              SizedBox(
                  width: screenWidth * 0.8,
                  height: 25,
                  child:
                  LinearProgressIndicator(
                    value: value / goalValue,
                    backgroundColor: AppColors.red,
                    borderRadius: BorderRadius.circular(15),
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.turquoise),
                    // Цвет заполнения
                  ),
              ),
              const Spacer(),
            ],
          ),
        );
      }),
    );
  }
}
