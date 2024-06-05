import 'package:app1/internal/cubit/workout/workout_cubit.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/router/router.dart';
import 'package:app1/presentation/widgets/custom_buttons/primary_app_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:app1/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutMenuPage extends StatelessWidget {
  const WorkoutMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Тренировки',
        withoutRightIcon: true,
        withoutLeftIcon: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            PrimaryAppButton(
              onTap: (){
                context.router.push(const CurrentWorkoutRoute());
              },
              withColor: true,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              alignment: Alignment.center,
              child: Text(
                'Текущая',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.secondaryTextColor
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            PrimaryAppButton(
              onTap: (){},
              withColor: true,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              alignment: Alignment.center,
              child: Text(
                'Запланированная',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.secondaryTextColor
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            PrimaryAppButton(
              onTap: (){},
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              withColor: true,
              alignment: Alignment.center,
              child: Text(
                'Сохранённые',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.secondaryTextColor
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            PrimaryAppButton(
              onTap: (){
                context.read<WorkoutCubit>().getCompletedWorkoutsList();
                context.router.push(const CompletedWorkoutsRoute());
              },
              withColor: true,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              alignment: Alignment.center,
              child: Text(
                'Выполненные',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.secondaryTextColor
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
