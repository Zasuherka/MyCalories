import 'package:app1/domain/model/workout/exercise.dart';

class ExerciseRoundSet extends Exercise{
  String setCount;
  List<PhysicalActivity> physicalActivityList;

  ExerciseRoundSet({
    super.title = '',
    this.setCount = '',
    required this.physicalActivityList,
  });

  @override
  bool get isNotValid => title.isEmpty || setCount.isEmpty;

  factory ExerciseRoundSet.fromFirebase(Map<String, dynamic> json){
    return ExerciseRoundSet(
      title: json['title'] ?? '',
      setCount: json['setCount'] ?? '',
      physicalActivityList: parseListMapFromFirebase((json['physicalActivityList'] ?? []) as List<Object?>),
    );
  }

  @override
  Map<String, dynamic> toFirebase() {
    return {
      'exercise_round_set': {
        'title': title,
        'setCount': setCount,
        'physicalActivityList': physicalActivityList.map((e) => e.toFirebase()).toList(),
      }
    };
  }

  static List<PhysicalActivity> parseListMapFromFirebase(List<Object?> list){
    final List<PhysicalActivity> newList = [];
    for(int i = 0; i < list.length; i++){
      if(list[i] == null){
        continue;
      }
      newList.add(PhysicalActivity.fromFirebase(Map<String, dynamic>.from(list[i] as Map)));
    }
    return newList;
  }
}

class PhysicalActivity{
  String title;
  String repetitionsCount;

  PhysicalActivity({required this.title, required this.repetitionsCount});

  factory PhysicalActivity.fromFirebase(Map<String, dynamic> json){
    return PhysicalActivity(
        title: json['title'],
        repetitionsCount: json['repetitionsCount']
    );
  }

  Map<String, dynamic> toFirebase(){
    pragma(title);
    return {
      'title': title,
      'repetitionsCount': repetitionsCount
    };
  }
}