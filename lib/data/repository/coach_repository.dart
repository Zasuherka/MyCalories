import 'package:app1/data/database/database.dart';
import 'package:app1/data/dto/user_dto/user_dto.dart';
import 'package:app1/data/repository/user_repository.dart';
import 'package:app1/domain/model/user.dart';
import 'package:app1/domain/repository/i_user_repository.dart';

class CoachRepository{

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

  Future<void> requestCoach(AppUser coach) async{
    final localUser = _userRepository.localUser;

    if (localUser == null) {
      return;
    }

    coach.wardRequests.add(localUser);

    try{
      await _database.userData.updateUserInfo(appUserDto: AppUserDto.fromAppUser(coach));
      localUser.coachId = coach.coachId;
      await _database.userData.updateUserInfo(appUserDto: AppUserDto.fromAppUser(localUser));
      _userRepository.setUserInfo(localUser);
    }
    catch(_){
      rethrow;
    }
  }
}