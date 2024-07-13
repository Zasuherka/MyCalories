import 'package:app1/data/database/database.dart';
import 'package:app1/data/dto/workout_dto/workout_dto.dart';
import 'package:app1/domain/model/user.dart';
import 'package:app1/domain/model/workout/workout.dart';
import 'package:app1/domain/repository/i_user_repository.dart';
import 'package:app1/domain/repository/i_workout_repository.dart';
import 'package:intl/intl.dart';

class WorkoutRepository extends IWorkoutRepository{

  final IUserRepository _userRepository;
  final Database _database;

  WorkoutRepository({required IUserRepository userRepository, required Database database})
      : _userRepository = userRepository,
        _database = database;

  @override
  Stream<Workout?> getCurrentWorkout() {

    final AppUser? localUser = _userRepository.localUser;

    if(localUser == null){
      throw 'localUser is null';
    }

    try{
      return _database.workout.getCurrentWorkout(localUser.userId).map((event) {
        if(event == null){
          return null;
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

    try{
      await _database.workout.setCurrentWorkout(WorkoutDto.fromWorkout(workout), localUser.userId);
    }
    catch(error){
      rethrow;
    }
  }

  @override
  Future<void> endCurrentWorkout(Workout workout) async{
    final AppUser? localUser = _userRepository.localUser;

    if(localUser == null){
      throw 'localUser is null';
    }

    try{
      final String formattedDate = DateFormat('dd.MM.yyyy').format(DateTime.now());
      workout.saveAt = formattedDate;

      await Future.wait([
        _database.workout.deleteCurrentWorkout(localUser.userId),
        _database.workout.saveCurrentWorkoutInListCompletedWorkouts(
          WorkoutDto.fromWorkout(workout),
          localUser.userId,
        ),
      ]);
    }
    catch(error){
      rethrow;
    }
  }

  @override
  Future<List<Workout>> getCompletedWorkoutsList() async{
    final AppUser? localUser = _userRepository.localUser;

    if(localUser == null){
      throw 'localUser is null';
    }

    try{
      final List<WorkoutDto> listWorkoutDto = await _database.workout.getCompletedWorkoutsList(localUser.userId);
      final List<Workout> listWorkout = listWorkoutDto.map((e) => e.toWorkout()).toList();
      return listWorkout;
    }
    catch(error){
      rethrow;
    }
  }
}