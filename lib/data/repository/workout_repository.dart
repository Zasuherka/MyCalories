import 'package:app1/data/database/database.dart';
import 'package:app1/data/dto/workout_dto/workout_dto.dart';
import 'package:app1/data/repository/user_repository.dart';
import 'package:app1/domain/model/user.dart';
import 'package:app1/domain/model/workout/workout.dart';
import 'package:app1/domain/repository/i_user_repository.dart';
import 'package:app1/domain/repository/i_workout_repository.dart';

class WorkoutRepository extends IWorkoutRepository{

  final IUserRepository _userRepository = UserRepository();
  final Database _database = Database();

  @override
  Stream<Workout> getCurrentWorkout() {

    final AppUser? localUser = _userRepository.localUser;

    if(localUser == null){
      throw 'localUser is null';
    }

    try{
      return _database.currentWorkout.getCurrentWorkout(localUser.userId).map((event) {
        try{
          print(event.toWorkout());
        }
        catch(error){
          print(error);
        }
        return event.toWorkout();
      });
    }
    catch(error){
      throw Exception(error);
    }
  }

  @override
  Future<void> setCurrentWorkout(Workout workout) async {
    final AppUser? localUser = _userRepository.localUser;

    if(localUser == null){
      throw 'localUser is null';
    }
    print(workout.listExercise.length);

    try{
      await _database.currentWorkout.setCurrentWorkout(WorkoutDto.fromWorkout(workout), localUser.userId);
    }
    catch(error){
      print(error);
      rethrow;
    }
  }

}