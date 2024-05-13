part of 'database.dart';

class _CurrentWorkoutData{

  Future<void> setCurrentWorkout(WorkoutDto workout, String userId) async {
    try{
      await _usersRef.child('$userId/currentWorkout')
          .set(workout.toFirebase());
    }
    catch(error){
      throw Exception(error);
    }
  }

  Stream<WorkoutDto> getCurrentWorkout(String userId) {
    try{
      return _usersRef.child('$userId/currentWorkout').onValue.map((event) {
        if(event.snapshot.value == null) throw Exception('currentWorkout is empty');
        final Map<String, dynamic> json = Map<String, dynamic>
            .from(event.snapshot.value as Map);
        return WorkoutDto.fromFirebase(json);
      });
    }
    catch(error){
      throw Exception(error);
    }
  }
}