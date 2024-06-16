import 'package:app1/data/database/database.dart';
import 'package:app1/data/dto/user_dto/user_dto.dart';
import 'package:app1/data/repository/user_repository.dart';
import 'package:app1/domain/model/user.dart';
import 'package:app1/domain/repository/i_user_repository.dart';

class WardRepository{
  final IUserRepository _userRepository = UserRepository();
  final Database _database = Database();

  Future<List<AppUser>> getWardRequestsList() async{
    final localUser = _userRepository.localUser;

    if (localUser == null) {
      return [];
    }

    return _getUsersList(localUser.wardRequests);
  }

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
    }
    catch(error){
      rethrow;
    }
  }
}