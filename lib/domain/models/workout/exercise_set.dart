import 'package:app1/domain/model/workout/exercise.dart';

class ExerciseSet extends Exercise{
  String setCount;
  String repetitionsCount;

  ExerciseSet({
    super.title = '',
    this.setCount = '',
    this.repetitionsCount = '',
  });

  @override
  bool get isNotValid => title.isEmpty || setCount.isEmpty || repetitionsCount.isEmpty;

  factory ExerciseSet.fromJson(Map<String, dynamic> json){
    return ExerciseSet(
      title: json['title'] ?? '',
      setCount: json['setCount'] ?? '',
      repetitionsCount: json['repetitionsCount'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'exercise_set': {
        'title': title,
        'setCount': setCount,
        'repetitionsCount': repetitionsCount,
      }
    };
  }
}