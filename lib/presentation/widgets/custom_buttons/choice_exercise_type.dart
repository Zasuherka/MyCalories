import 'package:app1/domain/model/workout/exercise.dart';
import 'package:app1/domain/model/workout/exercise_round_set.dart';
import 'package:app1/domain/model/workout/exercise_set.dart';
import 'package:app1/presentation/constants.dart';
import 'package:flutter/material.dart';

class ChoiceExerciseType extends StatelessWidget {
  final void Function(Exercise) onTap;
  const ChoiceExerciseType({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        boxShadow: boxShadow,
        color: AppColors.primaryButtonColor,
        borderRadius: BorderRadius.circular(25)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => onTap(ExerciseSet()),
            child: const Text(
              'Подходы',
            ),
          ),
          InkWell(
            onTap: () => onTap(ExerciseRoundSet(physicalActivityList: [])),
            child: const Text(
              'Сет',
            ),
          ),
        ],
      ),
    );
  }
}
