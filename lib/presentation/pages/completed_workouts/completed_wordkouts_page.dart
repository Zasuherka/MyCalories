
import 'package:app1/domain/model/workout/workout.dart';
import 'package:app1/internal/cubit/workout/workout_cubit.dart';
import 'package:app1/presentation/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompletedWorkoutPage extends StatelessWidget {
  const CompletedWorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final WorkoutCubit workoutCubit = context.read<WorkoutCubit>();
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: MediaQuery
              .of(context)
              .padding
              .top + 20,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: AppColors.greenGradient
            ),
          )
      ),
      body: BlocBuilder<WorkoutCubit, WorkoutState>(
        builder: (BuildContext context, WorkoutState state){
          return state.maybeMap(
              loading: (_) => Center(
                child: Image.asset(
                  'images/bouncing-circles.gif',
                  height: 100,
                ),
              ),
              orElse: (){
                final List<Workout> list = workoutCubit.completedWorkoutsList;
                return Column(
                  children: [

                  ],
                );
              });
        },
      ),
    );
  }
}
