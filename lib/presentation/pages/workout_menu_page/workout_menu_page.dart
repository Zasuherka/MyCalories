import 'package:app1/internal/bloc/coach_bloc/coach_bloc.dart';
import 'package:app1/internal/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:app1/internal/cubit/workout_cubit/workout_cubit.dart';
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
    context.read<CoachBloc>().add(const CoachEvent.updateLocalUserInfo());
    final userIsCoach = context.read<UserInfoBloc>().localUser?.isCoach ?? false;
    const Widget verticalOffset = SizedBox(
      height: 10,
    );
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
            PrimaryAppButton(
              onTap: (){
                if(userIsCoach){
                  context.router.push(const WardsListRoute());
                } else{
                  context.router.push(const MyCoachRoute());
                }
              },
              withColor: true,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              alignment: Alignment.center,
              child: Text(
                userIsCoach ? 'Подопечные' : 'Мой тренер',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.secondaryTextColor
                ),
              ),
            ),
            if(userIsCoach) ...[
              verticalOffset,
              PrimaryAppButton(
                onTap: (){
                  context.router.push(const WardsRequestsRoute());
                },
                withColor: true,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                alignment: Alignment.center,
                child: Text(
                  'Заявки на тренерство',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.secondaryTextColor
                  ),
                ),
              ),
            ],
            verticalOffset,
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
            if(!userIsCoach) ...[
              verticalOffset,
              PrimaryAppButton(
                onTap: (){
                  context.router.push(const ScheduledWorkoutRoute());
                },
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
            ],
            verticalOffset,
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
