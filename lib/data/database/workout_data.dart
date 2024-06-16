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

  Future<void> addScheduledWorkout(WorkoutDto? workoutDto, String userId) async{
    try{
      final DatabaseReference workoutRef = _usersRef.child(userId);
      workoutDto?.workoutId = null;
      await workoutRef.update({
        'scheduledWorkout': workoutDto?.toJson(),
      });
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
        listWorkout.add(WorkoutDto.fromFirebase(json));
      }

      return listWorkout;
    }
    catch(error){
      throw Exception(error);
    }
  }

  Future<WorkoutDto?> getInfoAboutScheduledWorkout(String userId) async{
    try{
      final DataSnapshot snapshot = await _usersRef.child('$userId/scheduledWorkout').get();
      if(snapshot.value == null) return null;
      final Map<String, dynamic> json = Map<String, dynamic>.from(snapshot.value as Map);
      return WorkoutDto.fromFirebase(json);
    }
    catch(_){
      rethrow;
    }
  }

  Stream<WorkoutDto?> getCurrentWorkout(String userId) {
    try{
      return _usersRef.child('$userId/currentWorkout').onValue.map((event) {
        if(event.snapshot.value == null) return null;
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