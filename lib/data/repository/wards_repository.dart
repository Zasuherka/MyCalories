import 'package:app1/data/database/database.dart';
import 'package:app1/data/dto/user_dto/user_dto.dart';
import 'package:app1/data/dto/workout_dto/workout_dto.dart';
import 'package:app1/domain/model/user.dart';
import 'package:app1/domain/model/workout/workout.dart';
import 'package:app1/domain/repository/I_wards_repository.dart';
import 'package:app1/domain/repository/i_user_repository.dart';
import 'package:intl/intl.dart';

class WardRepository implements IWardRepository{
  final IUserRepository _userRepository;
  final Database _database;

  WardRepository({required IUserRepository userRepository, required Database database})
      : _userRepository = userRepository,
        _database = database;

  @override
  Future<List<AppUser>> getWardRequestsList() async{
    final localUser = _userRepository.localUser;

    if (localUser == null) {
      return [];
    }

    return _getUsersList(localUser.wardRequests);
  }

  @override
  Future<List<AppUser>> getWardsList() async{
    final localUser = _userRepository.localUser;

    if (localUser == null) {
      return [];
    }

    return _getUsersList(localUser.wards);
  }

  Future<List<AppUser>> _getUsersList(List<String> userIdList) async{
    final List<AppUser> wardRequestsList = [];

    for(int i = 0; i < userIdList.length; i++){
      try{
        final AppUserDto? appUserDto = await _database.userData
            .getAllInfoAboutUser(userId: userIdList[i]);
        if(appUserDto != null){
          wardRequestsList.add(appUserDto.toAppUser());
        }
      }
      catch(_){

      }
    }
    return wardRequestsList;
  }

  @override
  Future<void> replyWard(AppUser ward, bool reply) async{
    final localUser = _userRepository.localUser;

    if (localUser == null) {
      return;
    }

    ward.requestCoachId = null;

    ward.coachId = reply ? localUser.userId : null;

    localUser.wardRequests.removeWhere((element) => element == ward.userId);

    if(reply){
       localUser.wards.add(ward.userId);
    }

    try{
      await Future.wait([
        _database.userData.updateUserInfo(appUserDto: AppUserDto.fromAppUser(localUser)),
        _database.userData.updateUserInfo(appUserDto: AppUserDto.fromAppUser(ward)),
      ]);
      _userRepository.setUserInfo(localUser);
    }
    catch(error){
      rethrow;
    }
  }

  @override
  Future<void> sendWorkout(Workout workout, AppUser ward) async{
    try{
      final String formattedDate = DateFormat('dd.MM.yyyy').format(DateTime.now());
      workout.saveAt = formattedDate;

      await Future.wait([
        _database.workout.addScheduledWorkout(
          WorkoutDto.fromWorkout(workout),
          ward.userId,
        ),
      ]);
    }
    catch(error){
      rethrow;
    }
  }

  @override
  Future<void> removeWard(AppUser ward) async{
    final localUser = _userRepository.localUser;

    if (localUser == null) {
      return;
    }

    try{
      ward.coachId = null;
      await _database.userData.updateUserInfo(appUserDto: AppUserDto.fromAppUser(ward));
      localUser.wards.removeWhere((element) => element == ward.userId);
      await _database.userData.updateUserInfo(appUserDto: AppUserDto.fromAppUser(localUser));
      _userRepository.setUserInfo(localUser);
    }
    catch(_){
      rethrow;
    }
  }

  @override
  Future<List<Workout>> getCompletedWorkouts(String userId) async{
    try{
      final List<WorkoutDto> listWorkoutDto = await _database.workout.getCompletedWorkoutsList(userId);
      final List<Workout> listWorkout = listWorkoutDto.map((e) => e.toWorkout()).toList();
      return listWorkout.reversed.toList();
    }
    catch(error){
      return [];
    }
  }
}