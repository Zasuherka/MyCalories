import 'package:app1/bloc/eating_food_bloc/eating_food_bloc.dart';
import 'package:app1/bloc/user_image_bloc/user_image_bloc.dart';
import 'package:app1/bloc/user_info_bloc/user_info_bloc.dart';
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

    return BlocBuilder<EatingFoodBloc, EatingFoodState>(
        builder: (context, state){
          value = context.read<EatingFoodBloc>().allCalories;
          goalValue = context.read<UserInfoBloc>().localUser?.caloriesGoal?.toDouble() ?? 1000;
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
            const Spacer(),
            Text(
              'КАЛОРИИ: ${value.toInt()}/${goalValue.toInt()}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const Spacer(),
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
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.turquoise),
                    // Цвет заполнения
                  ),
                )
            ),
            const Spacer(),
          ],
        ),
      );
    });
  }
}
