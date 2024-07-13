import 'package:app1/domain/model/workout/exercise_cardio.dart';
import 'package:app1/domain/model/workout/exercise_round_set.dart';
import 'package:app1/domain/model/workout/exercise_set.dart';
import 'package:app1/internal/cubit/workout_cubit/workout_cubit.dart';
import 'package:app1/presentation/widgets/custom_app_bar.dart';
import 'package:app1/presentation/widgets/workout/workout_cardio_inactive.dart';
import 'package:app1/presentation/widgets/workout/workout_round_set_inactive.dart';
import 'package:app1/presentation/widgets/workout/workout_set_inactive.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CompletedWorkoutPage extends StatelessWidget {
  const CompletedWorkoutPage({super.key});
  @override
  Widget build(BuildContext context) {
    final WorkoutCubit workoutCubit = context.read<WorkoutCubit>();
    return BlocConsumer<WorkoutCubit, WorkoutState>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          appBar: CustomAppBar(
            title: workoutCubit.completedWorkout.title,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: workoutCubit.completedWorkout.listExercise.length,
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  itemBuilder: (context, index) {
                    final exercise = workoutCubit.completedWorkout.listExercise[index];
                    if (exercise is ExerciseSet) {
                      return WorkoutSetInactive(
                        indexExercise: index,
                      );
                    } else
                    if(exercise is ExerciseRoundSet){
                      return WorkoutRoundSetInactive(
                        indexExercise: index,
                      );
                    } else
                    if(exercise is ExerciseCardio){
                      return WorkoutCardioInactive(
                        indexExercise: index,
                      );
                    }
                    return const SizedBox();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
