import 'package:app1/domain/model/workout/exercise.dart';

class ExerciseCardio extends Exercise{

  String count;

  ExerciseCardio({
    super.title = '',
    this.count = '',
  });

  @override
  bool get isNotValid => title.isEmpty || count.isEmpty;

  factory ExerciseCardio.fromJson(Map<String, dynamic> json){
    return ExerciseCardio(
      title: json['title'] ?? '',
      count: json['count'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'exercise_cardio': {
        'title': title,
        'count': count,
      }
    };
  }

}