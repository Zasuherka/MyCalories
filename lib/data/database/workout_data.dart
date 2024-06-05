part of 'database.dart';

class _WorkoutData{

  Future<void> setCurrentWorkout(WorkoutDto workout, String userId) async {
    try{
      await _usersRef.child('$userId/currentWorkout')
          .set(workout.toJson());
    }
    catch(error){
      throw Exception(error);
    }
  }

  Future<void> deleteCurrentWorkout(String userId) async {
    try{
      await _usersRef.child('$userId/currentWorkout')
          .remove();
    }
    catch(error){
      throw Exception(error);
    }
  }

  Future<WorkoutDto> saveCurrentWorkoutInListCompletedWorkouts(WorkoutDto workoutDto, String userId) async{
    try{
      final DatabaseReference workoutRef = _usersRef.child('$userId/completedWorkouts').push();
      await workoutRef.set(workoutDto.toJson());
      workoutDto.workoutId = workoutRef.key;
      return workoutDto;
    }
    catch(error){
      throw Exception(error);
    }
  }

  Future<List<WorkoutDto>> getCompletedWorkoutsList(String userId) async{
    try{
      List<WorkoutDto> listWorkout = [];
      final DataSnapshot snapshot = await _usersRef.child('$userId/completedWorkouts').get();

      for(DataSnapshot workoutSnap in snapshot.children){
        final Map<String, dynamic> json = Map<String, dynamic>.from(workoutSnap.value as Map);
        listWorkout.add(WorkoutDto.fromJson(json));
      }

      return listWorkout;
    }
    catch(error){
      throw Exception(error);
    }
  }

  Stream<WorkoutDto?> getCurrentWorkout(String userId) {
    try{
      return _usersRef.child('$userId/currentWorkout').onValue.map((event) {
        if(event.snapshot.value == null) return null;
        final Map<String, dynamic> json = Map<String, dynamic>
            .from(event.snapshot.value as Map);
        return WorkoutDto.fromJson(json);
      });
    }
    catch(error){
      throw Exception(error);
    }
  }
}