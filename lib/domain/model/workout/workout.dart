import 'package:app1/domain/model/workout/exercise.dart';

class Workout {
  String? workoutId;
  String title;
  List<Exercise> listExercise;

  Workout({
    required this.title,
    required this.listExercise,
    this.workoutId
  });
}