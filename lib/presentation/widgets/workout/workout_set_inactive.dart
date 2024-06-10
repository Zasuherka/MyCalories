import 'package:app1/domain/models/workout/exercise_set.dart';
import 'package:app1/internal/cubit/workout/workout_cubit.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/widgets/workout/text_fields/active_workout_title.dart';
import 'package:app1/presentation/widgets/workout/text_fields/workout_set_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutSetInactive extends StatelessWidget {
  final int indexExercise;

  const WorkoutSetInactive({
    super.key,
    required this.indexExercise,
  });

  @override
  Widget build(BuildContext context) {
    final WorkoutCubit workoutCubit = context.read<WorkoutCubit>();
    final ExerciseSet workout = workoutCubit
        .completedWorkout.listExercise[indexExercise] as ExerciseSet;
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: boxShadow,
          color: AppColors.primaryButtonColor
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(workout.title),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              const Text('Подходы:'),
              const SizedBox(width: 5,),
              Text(workout.setCount),
              const Spacer(),
              const Text('Повторений:'),
              const SizedBox(width: 5,),
              Text(workout.repetitionsCount),
              const Spacer(),
            ],
          )
        ],
      ),
    );
  }
}
