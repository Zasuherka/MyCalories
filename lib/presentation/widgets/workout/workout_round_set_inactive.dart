import 'package:app1/domain/model/workout/exercise_round_set.dart';
import 'package:app1/internal/cubit/workout_cubit/workout_cubit.dart';
import 'package:app1/presentation/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutRoundSetInactive extends StatelessWidget {
  final int indexExercise;

  const WorkoutRoundSetInactive({
    super.key,
    required this.indexExercise,
  });

  @override
  Widget build(BuildContext context) {
    final WorkoutCubit workoutCubit = context.read<WorkoutCubit>();
    final ExerciseRoundSet workout = workoutCubit
        .completedWorkout.listExercise[indexExercise] as ExerciseRoundSet;
    final List<PhysicalActivity> physicalActivityList = workout.physicalActivityList;
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const SizedBox(width: 10,),
              Expanded(
                flex: 8,
                child: Text(workout.title),
              ),
              const SizedBox(width: 10,),
              Expanded(
                flex: 4,
                child: Text(workout.setCount),
              ),
              const SizedBox(width: 10,),
            ],
          ),
          if(physicalActivityList.isNotEmpty) const SizedBox(
            height: 20,
          ),
          if(physicalActivityList.isNotEmpty) Table(
            border: TableBorder.all(
              color: AppColors.turquoise,
            ),
            columnWidths: const {
              0: IntrinsicColumnWidth(flex: 6),
              1: IntrinsicColumnWidth(flex: 2),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: List.generate(physicalActivityList.length, (index) {
              return TableRow(
                  children: [
                    TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              physicalActivityList[index].title,
                          ),
                        )
                    ),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            physicalActivityList[index].repetitionsCount,
                            textAlign: TextAlign.center,
                          ),
                        )
                    ),
                  ]
              );
            }),
          ),
          if(physicalActivityList.isNotEmpty) const SizedBox(height: 20,)
        ],
      ),
    );
  }
}

