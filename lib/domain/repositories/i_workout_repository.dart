import 'package:app1/domain/models/workout/workout.dart';

abstract class IWorkoutRepository{
  Future<void> setCurrentWorkout(Workout workout);

  Future<void> endCurrentWorkout(Workout workout);

  Future<List<Workout>> getCompletedWorkoutsList();

  Stream<Workout?> getCurrentWorkout();
}