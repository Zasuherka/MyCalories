import 'package:app1/domain/model/workout/exercise.dart';
import 'package:app1/domain/model/workout/workout.dart';

class WorkoutDto {
  String? workoutId;
  String title;
  String? saveAt;
  List<Map<String, dynamic>> listExercise;

  WorkoutDto({
    required this.title,
    required this.listExercise,
    this.workoutId,
    this.saveAt,
  });

  factory WorkoutDto.fromFirebase(Map<String, dynamic> json){
    return WorkoutDto(
        workoutId: json['workoutId'],
        title: json['title'],
        listExercise: parseListMapfromJson((json['listExercise'] ?? []) as List<Object?>),
        saveAt: json['saveAt']
    );
  }

  Map<String, dynamic> toJson() {
    if(workoutId == null){
      return {
        'title': title,
        'listExercise': listExercise,
        'saveAt': saveAt,
      };
    }
    return {
      workoutId!: {
        'title': title,
        'listExercise': listExercise,
        'saveAt': saveAt
      }
    };
  }

  factory WorkoutDto.fromWorkout(Workout workout){
    return WorkoutDto(
        workoutId: workout.workoutId,
        title: workout.title,
        listExercise: _parseListExerciseToMapFromList(workout.listExercise),
        saveAt: workout.saveAt,
    );
  }

  Workout toWorkout() {
    return Workout(
        workoutId: workoutId,
        title: title,
        listExercise: parseListExerciseToListFromMap(listExercise),
        saveAt: saveAt
    );
  }

  static List<Map<String, dynamic>> parseListMapfromJson(List<Object?> list){
    final List<Map<String, dynamic>> newList = [];
    for(int i = 0; i < list.length; i++){
      if(list[i] == null){
        continue;
      }
      newList.add(Map<String, dynamic>.from(list[i] as Map));
    }
    return newList;
  }

  static List<Exercise> parseListExerciseToListFromMap(List listMap){
    final List<Exercise> list = [];
    for(int i = 0; i < listMap.length; i++){
      final map = (listMap[i] as Map).cast<String, dynamic>();
      list.add(Exercise.fromJson(map));
    }
    return list;
  }

  static List<Map<String, dynamic>> _parseListExerciseToMapFromList(List<Exercise> list){
    List<Map<String, dynamic>> listMap = [];
    for(int i = 0; i < list.length; i++){
      final exerciseMap = list[i].toJson();
      listMap.add(exerciseMap);
    }
    return listMap;
  }
}