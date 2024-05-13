import 'package:app1/domain/model/workout/workout.dart';

abstract class IWorkoutRepository{
  Future<void> setCurrentWorkout(Workout workout);

  Stream<Workout> getCurrentWorkout();
}