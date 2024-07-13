import 'package:app1/data/database/database.dart';
import 'package:app1/data/dto/user_dto/user_dto.dart';
import 'package:app1/data/dto/workout_dto/workout_dto.dart';
import 'package:app1/domain/model/collection_view.dart';
import 'package:app1/domain/model/user.dart';
import 'package:app1/domain/model/workout/workout.dart';
import 'package:app1/domain/repository/i_coach_repository.dart';
import 'package:app1/domain/repository/i_user_repository.dart';

class CoachRepository implements ICoachRepository{
  final IUserRepository _userRepository;
  final Database _database;

  CoachRepository({required IUserRepository userRepository, required Database database})
      : _userRepository = userRepository,
        _database = database;

  @override
  Future<List<AppUser>> searchCoach(String searchText) async {
    final localUser = _userRepository.localUser;

    if (localUser == null) {
      return [];
    }

    final List<AppUserDto> appUserDtoList = await _database.userData.searchUser(
      searchText,
      localUser.userId,
    );
    final List<AppUser> userList = appUserDtoList.map((e) => e.toAppUser()).toList();
    return userList;
  }

  @override
  Future<AppUser> getCoachInfo(String coachId) async{
    try{
      final AppUserDto? appUserDto = await _database.userData.getAllInfoAboutUser(userId: coachId);
      if(appUserDto == null){
        throw Exception('this coach does not exist');
      }
      return appUserDto.toAppUser();
    }
    catch(error){
      rethrow;
    }
  }

  @override
  Future<void> requestCoach(AppUser coach) async {
    final localUser = _userRepository.localUser;

    if (localUser == null) {
      return;
    }

    coach.wardRequests.removeWhere((element) => element == localUser.userId);
    coach.wardRequests.add(localUser.userId);

    try {
      if(localUser.requestCoachId != null){
        await _database.userData.cancelCoachRequest(localUser.requestCoachId!, localUser.userId);
        localUser.requestCoachId = null;
      }
      await _database.userData.updateUserInfo(appUserDto: AppUserDto.fromAppUser(coach));
      localUser.requestCoachId = coach.userId;
      await _database.userData.updateUserInfo(appUserDto: AppUserDto.fromAppUser(localUser));
      _userRepository.setUserInfo(localUser);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> removeCoach(AppUser coach) async{
    final localUser = _userRepository.localUser;

    if (localUser == null) {
      return;
    }

    try{
      coach.wards.removeWhere((element) => element == localUser.userId);
      await _database.userData.updateUserInfo(appUserDto: AppUserDto.fromAppUser(coach));
      localUser.requestCoachId = null;
      localUser.coachId = null;
      await _database.userData.updateUserInfo(appUserDto: AppUserDto.fromAppUser(localUser));
      _userRepository.setUserInfo(localUser);
    }
    catch(error){
      rethrow;
    }
  }

  @override
  Future<List<CollectionView>> getCoachCollectionViewList(List<String> listCollectionsId) async{
    try{
      return await _database.collectionData.getUserListCollection(
          listCollectionsId
      );
    }
    catch(_){
      return [];
    }
  }

  @override
  Future<Workout?> getInfoAboutScheduledWorkout() async{
    final localUser = _userRepository.localUser;

    if (localUser == null) {
      return null;
    }

    try{
      final WorkoutDto? workoutDto = await _database.workout.getInfoAboutScheduledWorkout(localUser.userId);
      if(workoutDto == null) return null;
      return workoutDto.toWorkout();
    }
    catch(error){
      return null;
    }
  }

  @override
  Future<void> startScheduledWorkout(Workout workout) async{
    final localUser = _userRepository.localUser;

    if (localUser == null) {
      return;
    }

    try{
      await Future.wait([
        _database.workout.setCurrentWorkout(WorkoutDto.fromWorkout(workout), localUser.userId),
        _database.workout.addScheduledWorkout(null, localUser.userId),
      ]);
    }
    catch(_){}
  }
}
