import 'package:app1/domain/model/workout/exercise_cardio.dart';
import 'package:app1/internal/bloc/wards/wards_bloc.dart';
import 'package:app1/presentation/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutCardioInactive extends StatelessWidget {
  final int indexExercise;

  const WorkoutCardioInactive({
    super.key,
    required this.indexExercise,
  });

  @override
  Widget build(BuildContext context) {
    final WardsBloc wardBloc = context.read<WardsBloc>();
    final ExerciseCardio workout = wardBloc
        .completedWorkout.listExercise[indexExercise] as ExerciseCardio;
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
          Text('Минут/раз: ${workout.count}'),
        ],
      ),
    );
  }
}
