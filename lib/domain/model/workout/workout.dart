import 'package:app1/domain/model/workout/exercise.dart';

class Workout {
  String? workoutId;
  String title;
  List<Exercise> listExercise;
  String? saveAt;

  Workout({
    required this.title,
    required this.listExercise,
    this.workoutId,
    this.saveAt,
  });
}