import 'package:app1/domain/model/workout/exercise_cardio.dart';
import 'package:app1/domain/model/workout/exercise_round_set.dart';
import 'package:app1/domain/model/workout/exercise_set.dart';
import 'package:app1/internal/bloc/wards_bloc/wards_bloc.dart';
import 'package:app1/presentation/pages/ward_page/widgets/workout_cardio_inactive.dart';
import 'package:app1/presentation/pages/ward_page/widgets/workout_round_set_inactive.dart';
import 'package:app1/presentation/pages/ward_page/widgets/workout_set_inactive.dart';
import 'package:app1/presentation/widgets/custom_app_bar.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class WardCompletedWorkoutPage extends StatelessWidget {
  const WardCompletedWorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final WardsBloc wardsBloc = context.read<WardsBloc>();
    return BlocConsumer<WardsBloc, WardsState>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          appBar: CustomAppBar(
            title: wardsBloc.completedWorkout.title,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: wardsBloc.completedWorkout.listExercise.length,
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  itemBuilder: (context, index) {
                    final exercise = wardsBloc.completedWorkout.listExercise[index];
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
