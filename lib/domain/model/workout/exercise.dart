import 'package:app1/domain/model/workout/exercise_cardio.dart';
import 'package:app1/domain/model/workout/exercise_round_set.dart';
import 'package:app1/domain/model/workout/exercise_set.dart';

abstract class Exercise{
  String title;

  Exercise({required this.title});

  factory Exercise.fromJson(Map<String, dynamic> map){
    if(map['exercise_set'] != null){
      return ExerciseSet.fromJson(Map<String, dynamic>.from(map['exercise_set'] as Map));
    }
    if(map['exercise_round_set'] != null){
      return ExerciseRoundSet.fromJson(Map<String, dynamic>.from(map['exercise_round_set'] as Map));
    }
    if(map['exercise_cardio'] != null){
      return ExerciseCardio.fromJson(Map<String, dynamic>.from(map['exercise_cardio'] as Map));
    }
    throw Exception('Invalid exercise type');
  }

  bool get isNotValid{
    throw Exception('$runtimeType не переопределяет [isNotValid]');
  }

  Map<String, dynamic> toJson();
}