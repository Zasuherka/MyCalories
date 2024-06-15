import 'package:app1/data/database/database.dart';
import 'package:app1/data/dto/user_dto/user_dto.dart';
import 'package:app1/data/repository/user_repository.dart';
import 'package:app1/domain/model/user.dart';
import 'package:app1/domain/repository/i_user_repository.dart';

class CoachRepository {
  final IUserRepository _userRepository = UserRepository();
  final Database _database = Database();

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

  Future<void> requestCoach(AppUser coach) async {
    final localUser = _userRepository.localUser;

    if (localUser == null) {
      return;
    }

    coach.wardRequests.removeWhere((element) => element.userId == localUser.userId);
    coach.wardRequests.add(localUser);

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
}
