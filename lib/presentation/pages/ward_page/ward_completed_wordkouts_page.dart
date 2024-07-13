import 'package:app1/domain/model/workout/workout.dart';
import 'package:app1/internal/bloc/wards_bloc/wards_bloc.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/router/router.dart';
import 'package:app1/presentation/widgets/custom_app_bar.dart';
import 'package:app1/presentation/widgets/custom_buttons/primary_app_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class WardCompletedWorkoutsPage extends StatelessWidget {
  const WardCompletedWorkoutsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final WardsBloc wardsBloc = context.read<WardsBloc>();
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Выполненные',
        withoutRightIcon: true,
      ),
      body: BlocConsumer<WardsBloc, WardsState>(
        listener: (context, state){
        },
        builder: (context, state){
          final List<Workout> workoutList = wardsBloc.completedWorkoutsList;
          return state.maybeMap(
            loading: (_) => Center(
              child: Image.asset(
                'images/bouncing-circles.gif',
                height: 100,
              ),
            ),
            orElse: () => ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                itemCount: workoutList.length,
                itemBuilder: (context, index){
                  return PrimaryAppButton(
                    onTap: () {
                      wardsBloc.setCompletedWorkout(workoutList[index]);
                      context.router.push(const WardCompletedWorkoutRoute());
                    },
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    withColor: true,
                    color: AppColors.primaryButtonColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          workoutList[index].title,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(workoutList[index].saveAt.toString()),
                      ],
                    ),
                  );
                }
            ),
          );
        },
      ),
    );
  }
}
